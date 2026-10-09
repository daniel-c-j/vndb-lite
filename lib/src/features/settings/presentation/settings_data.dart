import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/custom_label.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/core/_core.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/lower_parts/bottom_progress_indicator_state.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/buttons/refresh_button.dart';
import 'package:vndb_lite/src/features/settings/application/settings_service.dart';
import 'package:vndb_lite/src/features/collection/data/local/local_collection_repo.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/components/settings_snackbar.dart';
import 'package:vndb_lite/src/features/settings/presentation/dialog/settings_dialog.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_data_state.dart';
import 'package:vndb_lite/src/features/sync/presentation/auth_screen_controller.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/constants/local_db_constants.dart';
import 'package:vndb_lite/src/core/local_db/shared_prefs.dart';

class SettingsData extends ConsumerStatefulWidget {
  const SettingsData({super.key});

  @override
  ConsumerState<SettingsData> createState() => _SettingsDataState();
}

class _SettingsDataState extends ConsumerState<SettingsData>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _offsetAnimation = _animationController
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(
          Tween<Offset>(begin: const Offset(0, -0.5), end: const Offset(0, 0)),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _refreshApp({bool all = false, bool verbose = false}) async {
    await AppBarRefreshButton.tap(allMainScreen: all, verbose: verbose);
    if (mounted) setState(() {});
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _autoUpdateCheckSwitch() async {
    final autoUpdate = ref.read(settingsDataStateProvider).autoUpdate;
    ref.read(settingsDataStateProvider.notifier).autoUpdate = !autoUpdate;

    await _refreshApp();
  }

  Future<void> _exportCollectionBackup() async {
    try {
      final backupText = const JsonEncoder.withIndent(
        '  ',
      ).convert(ref.read(localCollectionRepoProvider).exportBackup());
      if (Platform.isLinux) {
        final selectedPath = await FilePicker.platform.saveFile(
          dialogTitle: 'Export collection backup',
          fileName: 'vnpockets-collection-backup.json',
          type: FileType.custom,
          allowedExtensions: ['json'],
        );
        if (selectedPath == null) return;
        final path =
            selectedPath.toLowerCase().endsWith('.json')
                ? selectedPath
                : '$selectedPath.json';
        await File(path).writeAsString(backupText);
        feedbackSnackBar(text: 'Collection backup saved.');
        return;
      }

      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/vnpockets-collection-backup.json');
      await file.writeAsString(backupText);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'VNPockets collection backup',
          subject: 'VNPockets collection backup',
        ),
      );
      feedbackSnackBar(text: 'Choose Files or another app to save the backup.');
    } catch (_) {
      feedbackSnackBar(text: 'Backup export failed.', icon: Icons.error);
    }
  }

  Future<void> _importCollectionBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final path = result?.files.single.path;
    if (path == null) return;
    try {
      final decoded = jsonDecode(await File(path).readAsString());
      if (decoded is! Map<String, dynamic>) throw const FormatException();
      final count = await ref
          .read(localCollectionRepoProvider)
          .importBackup(decoded);
      ref.invalidate(collectionContentControllerProvider);
      await _refreshApp(all: true);
      feedbackSnackBar(text: '$count collection entries imported.');
    } catch (_) {
      feedbackSnackBar(
        text: 'Import failed: choose a VNPockets backup file.',
        icon: Icons.error,
      );
    }
  }

  Future<void> _exportFullBackup() async {
    try {
      final prefs = ref.read(sharedPrefProvider);
      final docs = await getApplicationDocumentsDirectory();
      final settings = <String, dynamic>{
        for (final key in prefs.getKeys().where(
          (key) =>
              key == DBKeys.THEME_CONF ||
              key == DBKeys.AMOLED_ACCENT_COLOR ||
              key == DBKeys.JAPANESE_TITLES_CONF ||
              key == DBKeys.JAPANESE_UI_CONF ||
              key == DBKeys.COVER_CENSOR_CONF ||
              key == DBKeys.SHOW_CHART_CONF ||
              key == DBKeys.SHOW_COLLECTION_ITEM_LABELS ||
              key == DBKeys.GROUP_COLLECTION_BY_DEVELOPER ||
              key == DBKeys.CUSTOM_FONT_SIZE_CONF ||
              key == DBKeys.MAX_PREVIEW_ITEMS_CONF ||
              key == DBKeys.MAX_ITEMS_PER_ROW_PORTRAIT_CONF ||
              key == DBKeys.MAX_ITEMS_PER_ROW_LANDSCAPE_CONF ||
              key == DBKeys.HOME_ARRANGEMENT ||
              key == DBKeys.COLLECTION_ARRANGEMENT ||
              key == DBKeys.STARTUP_TAB,
        ))
          key: prefs.get(key),
      };
      final archive = Archive();
      final customCovers = <String, String>{};
      final manifest = {
        'format': 'vnpockets-full-backup',
        'version': 1,
        'collection': ref.read(localCollectionRepoProvider).exportBackup(),
        'settings': settings,
        'media': <String, String>{},
        'customCovers': customCovers,
      };
      final media = manifest['media'] as Map<String, String>;
      for (final file in docs.listSync().whereType<File>()) {
        final name = file.uri.pathSegments.last;
        if (!name.startsWith('vnpockets_background.') &&
            !name.startsWith('vnpockets_cover_'))
          continue;
        final archiveName = 'media/$name';
        archive.addFile(
          ArchiveFile(archiveName, file.lengthSync(), file.readAsBytesSync()),
        );
        media[name] = archiveName;
      }
      final background = prefs.getString(DBKeys.CUSTOM_BACKGROUND_PATH);
      if (background != null)
        manifest['backgroundFile'] = background.split('/').last;
      for (final key in prefs.getKeys().where(
        (key) => key.startsWith(DBKeys.CUSTOM_COVER_PATH),
      )) {
        final path = prefs.getString(key);
        if (path != null) customCovers[key] = path.split('/').last;
      }
      final manifestBytes = utf8.encode(
        const JsonEncoder.withIndent('  ').convert(manifest),
      );
      archive.addFile(
        ArchiveFile('backup.json', manifestBytes.length, manifestBytes),
      );
      final backupBytes = ZipEncoder().encodeBytes(archive);
      if (Platform.isLinux) {
        final selectedPath = await FilePicker.platform.saveFile(
          dialogTitle: 'Export full VNPockets backup',
          fileName: 'vnpockets-full-backup.zip',
          type: FileType.custom,
          allowedExtensions: ['zip'],
        );
        if (selectedPath == null) return;
        final path =
            selectedPath.toLowerCase().endsWith('.zip')
                ? selectedPath
                : '$selectedPath.zip';
        await File(path).writeAsBytes(backupBytes);
        feedbackSnackBar(text: 'Full backup saved.');
        return;
      }

      final output = await getTemporaryDirectory();
      final file = File('${output.path}/vnpockets-full-backup.zip');
      await file.writeAsBytes(backupBytes);
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], text: 'VNPockets full backup'),
      );
    } catch (_) {
      feedbackSnackBar(text: 'Full backup export failed.', icon: Icons.error);
    }
  }

  Future<void> _importFullBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    final path = result?.files.single.path;
    if (path == null) return;
    try {
      final archive = ZipDecoder().decodeBytes(await File(path).readAsBytes());
      final manifestFile = archive.findFile('backup.json');
      if (manifestFile == null) throw const FormatException();
      final manifest = jsonDecode(
        utf8.decode(manifestFile.content as List<int>),
      );
      if (manifest is! Map || manifest['format'] != 'vnpockets-full-backup') {
        throw const FormatException();
      }
      final docs = await getApplicationDocumentsDirectory();
      for (final file in archive.files.where(
        (file) => file.name.startsWith('media/'),
      )) {
        await File(
          '${docs.path}/${file.name.split('/').last}',
        ).writeAsBytes(file.content as List<int>);
      }
      final prefs = ref.read(sharedPrefProvider);
      final settings = manifest['settings'];
      if (settings is Map) {
        for (final entry in settings.entries) {
          if (entry.key is! String) continue;
          final key = entry.key as String;
          final value = entry.value;
          if (value is bool) await prefs.setBool(key, value);
          if (value is int) await prefs.setInt(key, value);
          if (value is String) await prefs.setString(key, value);
          if (value is List)
            await prefs.setStringList(key, value.whereType<String>().toList());
        }
      }
      final background = manifest['backgroundFile'];
      if (background is String)
        await prefs.setString(
          DBKeys.CUSTOM_BACKGROUND_PATH,
          '${docs.path}/$background',
        );
      final covers = manifest['customCovers'];
      if (covers is Map) {
        for (final entry in covers.entries) {
          if (entry.key is String && entry.value is String) {
            await prefs.setString(
              entry.key as String,
              '${docs.path}/${entry.value}',
            );
          }
        }
      }
      await ref
          .read(localCollectionRepoProvider)
          .importBackup(
            Map<String, dynamic>.from(manifest['collection'] as Map),
          );
      ref.invalidate(collectionContentControllerProvider);
      await _refreshApp(all: true);
      feedbackSnackBar(text: 'Full backup imported.');
    } catch (_) {
      feedbackSnackBar(text: 'Full backup import failed.', icon: Icons.error);
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _refreshVns() async {
    // TODO showDialog? Anything user friendly like the others below.
    if (ref.read(bottomProgressIndicatorProvider)) return;

    // Does not do any process whatsoever if there is no internet connection.
    final hasConnection = ref.read(connectivityNotifierProvider);
    if (!hasConnection) {
      feedbackSnackBar(
        text: 'Refresh failed.',
        iconColor: Colors.red,
        icon: Icons.warning,
      );
      return;
    }

    ref.read(bottomProgressIndicatorProvider.notifier).show = true;
    feedbackSnackBar(text: 'Refreshing...', icon: Icons.refresh);

    try {
      // This will redownload all collected vn phase01 and phase02 data.
      await ref
          .read(settingsServiceProvider)
          .refresh(
            onRefresh: (String title) {
              feedbackSnackBar(
                text:
                    (title.length > 15)
                        ? '${title.substring(0, 14)}... refreshed. '
                        : '$title refreshed. ',
              );
            },
          );

      await Future.delayed(const Duration(milliseconds: 2000));
      feedbackSnackBar(text: 'Refreshed.', icon: Icons.refresh);
      //
    } catch (e) {
      feedbackSnackBar(text: 'Refresh failed.', icon: Icons.error);
      //
    } finally {
      // Using emergency ref in case the widget disposed.
      ref_.read(bottomProgressIndicatorProvider.notifier).show = false;
      await _refreshApp(all: true);
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _deleteVns() async {
    await showSettingsDialog(
      title:
          "You are about to delete all visual novels in your collection. Are you sure?",
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsiveUI.own(0.05)),
        child: ShadowText(
          (ref.read(bottomProgressIndicatorProvider))
              ? 'Please wait until the current process is done.'
              : 'If you already once sucessfully synced with the cloud (VNDB), the next time you sync, '
                  'all VNs in your collection will finally be removed permanently.',
        ),
      ),
      yesOrNo: ref.read(bottomProgressIndicatorProvider) != true,
      yesButtonColor:
          (ref.read(bottomProgressIndicatorProvider))
              ? null
              : const Color.fromARGB(180, 255, 20, 0),
      yesFunction: () async {
        // If turns out there's an ongoing process, then dont remove auth.
        if (ref.read(bottomProgressIndicatorProvider)) return;

        final auth = ref.read(authScreenControllerProvider.notifier);
        feedbackSnackBar(text: 'Removing VNs...');

        // If user already once successfully synchronized, then all of the current vns, the next
        // time user sync again, will all be removed in the cloud.
        if (auth.isUserSynced()) {
          ref.read(settingsServiceProvider).deleteAll(sync: true);
        } else {
          ref.read(settingsServiceProvider).deleteAll(sync: false);
        }

        await _refreshApp(all: true);
        feedbackSnackBar(text: ' All VNs have been removed. ');
      },
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _clearCache() async {
    await showSettingsDialog(
      title: "Do you want to reset all data back to default?",
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsiveUI.own(0.05)),
        child: ShadowText(
          (ref.read(bottomProgressIndicatorProvider))
              ? 'Please wait until the current process is done.'
              : 'You would have to restart the app for the whole default configurations to take effect.',
        ),
      ),
      yesOrNo: ref.read(bottomProgressIndicatorProvider) != true,
      yesButtonColor:
          (ref.read(bottomProgressIndicatorProvider))
              ? null
              : const Color.fromARGB(180, 255, 20, 0),
      yesFunction: () async {
        // If turns out there's an ongoing process, then dont remove auth.
        if (ref.read(bottomProgressIndicatorProvider)) return;

        feedbackSnackBar(text: 'Resetting data...');

        // To immediately update the UI.
        await ref.read(settingsServiceProvider).removeAuth();
        ref.invalidate(authScreenControllerProvider);

        // Back to default.
        await ref.read(settingsServiceProvider).clearCache();
        await _refreshApp(all: true, verbose: true);

        feedbackSnackBar(
          text: 'Welcome to the default back!',
          icon: Icons.waving_hand,
        );
      },
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _removeAuth() async {
    await showSettingsDialog(
      title: "Revoke Authentication?",
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsiveUI.own(0.05)),
        child: ShadowText(
          (ref.read(bottomProgressIndicatorProvider))
              ? 'Please wait until the current process is done.'
              : 'Your data will remain as is as the latest synchronization sucessfully initiated.',
        ),
      ),
      yesOrNo: ref.read(bottomProgressIndicatorProvider) != true,
      yesButtonColor:
          (ref.read(bottomProgressIndicatorProvider))
              ? null
              : const Color.fromARGB(180, 255, 20, 0),
      yesFunction: () async {
        // If turns out there's an ongoing process, then dont remove auth.
        if (ref.read(bottomProgressIndicatorProvider)) return;

        await ref.read(settingsServiceProvider).removeAuth();
        ref.invalidate(authScreenControllerProvider);

        feedbackSnackBar(text: 'Authentication has been revoked.');
      },
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsDataStateProvider);
    final uId = ref.watch(authScreenControllerProvider);
    final userDidAuth = uId != null;

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _animationController.drive(
          CurveTween(curve: Curves.easeInToLinear),
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(responsiveUI.own(0.04)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              //
              CustomLabel(
                useBorder: true,
                borderRadius: 12,
                isSelected: false,
                borderColor: kColor(context).secondary,
                padding: EdgeInsets.all(responsiveUI.own(0.02)),
                onTap: () async => await _autoUpdateCheckSwitch(),
                children: [
                  ShadowText('Automatically check update at start '),
                  ShadowText(
                    (settings.autoUpdate) ? ' ON' : ' OFF',
                    fontWeight: FontWeight.bold,
                    color: (settings.autoUpdate) ? Colors.green : Colors.red,
                    shadows: [
                      Shadow(
                        color: Color.alphaBlend(
                          Colors.black.withOpacity(0.5),
                          kColor(context).primary,
                        ),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ],
              ),
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              // Refresh VNs
              SizedBox(height: responsiveUI.own(0.03)),
              CustomLabel(
                useBorder: true,
                borderRadius: 12,
                isSelected: false,
                borderColor: kColor(context).secondary,
                highlightColor: const Color.fromARGB(180, 240, 210, 50),
                padding: EdgeInsets.all(responsiveUI.own(0.02)),
                onTap: _refreshVns,
                children: [
                  ShadowText('Refresh all visual novel in collection'),
                ],
              ),

              SizedBox(height: responsiveUI.own(0.03)),
              CustomLabel(
                useBorder: true,
                borderRadius: 12,
                isSelected: false,
                borderColor: kColor(context).secondary,
                padding: EdgeInsets.all(responsiveUI.own(0.02)),
                onTap: _exportCollectionBackup,
                children: [ShadowText('Export collection backup')],
              ),

              SizedBox(height: responsiveUI.own(0.03)),
              CustomLabel(
                useBorder: true,
                borderRadius: 12,
                isSelected: false,
                borderColor: kColor(context).secondary,
                padding: EdgeInsets.all(responsiveUI.own(0.02)),
                onTap: _importCollectionBackup,
                children: [ShadowText('Import collection backup')],
              ),
              SizedBox(height: responsiveUI.own(0.03)),
              CustomLabel(
                useBorder: true,
                borderRadius: 12,
                isSelected: false,
                borderColor: kColor(context).secondary,
                padding: EdgeInsets.all(responsiveUI.own(0.02)),
                onTap: _exportFullBackup,
                children: [
                  ShadowText('Export full backup (settings & images)'),
                ],
              ),
              SizedBox(height: responsiveUI.own(0.03)),
              CustomLabel(
                useBorder: true,
                borderRadius: 12,
                isSelected: false,
                borderColor: kColor(context).secondary,
                padding: EdgeInsets.all(responsiveUI.own(0.02)),
                onTap: _importFullBackup,
                children: [
                  ShadowText('Import full backup (settings & images)'),
                ],
              ),

              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              // Delete VNs
              SizedBox(height: responsiveUI.own(0.03)),
              CustomLabel(
                useBorder: true,
                borderRadius: 12,
                isSelected: false,
                borderColor: kColor(context).secondary,
                highlightColor: const Color.fromARGB(180, 240, 70, 50),
                padding: EdgeInsets.all(responsiveUI.own(0.02)),
                onTap: _deleteVns,
                children: [ShadowText('Remove all visual novel in collection')],
              ),

              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              // Clear caches
              SizedBox(height: responsiveUI.own(0.03)),
              CustomLabel(
                useBorder: true,
                borderRadius: 12,
                isSelected: false,
                borderColor: kColor(context).secondary,
                highlightColor: const Color.fromARGB(180, 240, 70, 50),
                padding: EdgeInsets.all(responsiveUI.own(0.02)),
                onTap: _clearCache,
                children: [ShadowText('Reset all data')],
              ),
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              // Revoke Authentication
              if (userDidAuth) SizedBox(height: responsiveUI.own(0.03)),
              if (userDidAuth)
                CustomLabel(
                  useBorder: true,
                  borderRadius: 12,
                  isSelected: false,
                  borderColor: kColor(context).secondary,
                  highlightColor: const Color.fromARGB(180, 240, 210, 50),
                  padding: EdgeInsets.all(responsiveUI.own(0.02)),
                  onTap: _removeAuth,
                  children: [ShadowText('Revoke authentication (Logout)')],
                ),

              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              //
            ],
          ),
        ),
      ),
    );
  }
}
