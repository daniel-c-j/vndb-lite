import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/common_widgets/generic_background.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_data.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_theme.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

import '../../theme/theme_data_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showDataList = false;
  bool _showThemeList = false;
  bool _showVnPreviewList = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //
          Consumer(
            builder: (context, ref, child) {
              final theme = ref.watch(appThemeStateProvider);
              return GenericBackground(
                imagePath: theme.backgroundImgPath,
                useGradientOverlay: true,
              );
            },
          ),
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //
          Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              elevation: 8,
              toolbarHeight: responsiveUI.own(0.15),
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      kColor(context).primary.withAlpha(250),
                      kColor(context).primary.withAlpha(150),
                    ],
                  ),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios_new, size: responsiveUI.own(0.055)),
                color: kColor(context).tertiary,
              ),
              title: ShadowText('Settings', fontSize: responsiveUI.own(0.0525)),
            ),
            backgroundColor: kColor(context).primary.withOpacity(0.25),
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            // Body
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: responsiveUI.own(0.2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //
                  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  // Data list
                  InkWell(
                    onTap: () {
                      setState(() => _showDataList = !_showDataList);
                    },
                    child: ListTile(
                      tileColor: kColor(context).primary.withAlpha(50),
                      leading: Icon(
                        Icons.library_books,
                        color: kColor(context).secondary,
                        size: responsiveUI.own(0.06),
                      ),
                      title: ShadowText('Data'),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: responsiveUI.own(0.045),
                        vertical: responsiveUI.own(0.005),
                      ),
                      dense: true,
                      trailing: Icon(
                        (!_showDataList) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                        color: kColor(context).secondary,
                        size: responsiveUI.standardIcon,
                      ),
                    ),
                  ),
                  if (_showDataList) const SettingsData(),
                  //
                  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  // Theme
                  InkWell(
                    onTap: () {
                      setState(() => _showThemeList = !_showThemeList);
                    },
                    child: ListTile(
                      tileColor: kColor(context).primary.withAlpha(50),
                      leading: Icon(
                        Icons.settings_input_composite,
                        color: kColor(context).secondary,
                        size: responsiveUI.own(0.06),
                      ),
                      title: ShadowText('Theme'),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: responsiveUI.own(0.045),
                        vertical: responsiveUI.own(0.005),
                      ),
                      dense: true,
                      trailing: Icon(
                        (!_showThemeList) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                        color: kColor(context).secondary,
                        size: responsiveUI.standardIcon,
                      ),
                    ),
                  ),
                  if (_showThemeList) const SettingsTheme(),
                  //
                  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  // General
                  InkWell(
                    onTap: () {
                      setState(() => _showVnPreviewList = !_showVnPreviewList);
                    },
                    child: ListTile(
                      tileColor: kColor(context).primary.withAlpha(50),
                      leading: Icon(
                        Icons.amp_stories,
                        color: kColor(context).secondary,
                        size: responsiveUI.own(0.06),
                      ),
                      title: ShadowText('General'),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: responsiveUI.own(0.045),
                        vertical: responsiveUI.own(0.005),
                      ),
                      dense: true,
                      trailing: Icon(
                        (!_showVnPreviewList) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                        color: kColor(context).secondary,
                        size: responsiveUI.standardIcon,
                      ),
                    ),
                  ),
                  if (_showVnPreviewList) const SettingsGeneral(),
                  //
                  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
