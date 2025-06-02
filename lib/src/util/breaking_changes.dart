import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/common_widgets/custom_dialog.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/constants/local_db_constants.dart';
import 'package:vndb_lite/src/core/local_db/shared_prefs.dart';
import 'package:vndb_lite/src/features/collection/data/local/local_collection_repo.dart';
import 'package:vndb_lite/src/features/collection/domain/record.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/responsive.dart';

bool _isUpdatedInternallyFlag = false;

class BreakingChangesCounterMeasure extends ConsumerWidget {
  const BreakingChangesCounterMeasure({super.key});

  static Future<void> show(BuildContext context) async {
    if (_isUpdatedInternallyFlag) return;

    final isUpdatedInternally =
        ref_.read(sharedPrefProvider).getBool(DBKeys.BREAKING_CHANGE_UPDATE) ?? false;

    if (isUpdatedInternally) {
      _isUpdatedInternallyFlag = true;
      return;
    }

    return await showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder:
          (context) =>
              const CustomDialog(useContentPadding: true, content: BreakingChangesCounterMeasure()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!_isUpdatedInternallyFlag) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        final allRecords = await ref.read(localCollectionRepoProvider).getAllRecords();

        ref.read(localCollectionRepoProvider).addedViaAppNotBySync =
            allRecords.map((VnRecord record) => record.id).toSet().toList();

        ref.read(sharedPrefProvider).setBool(DBKeys.BREAKING_CHANGE_UPDATE, true);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShadowText(
          "WARNING: Breaking change update",
          align: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: responsiveUI.catgTitle,
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        SizedBox(height: responsiveUI.own(0.01)),
        const CircularProgressIndicator(padding: EdgeInsets.all(8)),
        SizedBox(height: responsiveUI.own(0.01)),
        const ShadowText(
          "We apologize for the inconvenience. "
          "Please do not close the app as we are trying to ensure the compatibility of the updated synchronization feature in this app. "
          "\n"
          "And don't worry, this will only happen once :)",
          align: TextAlign.center,
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
    );
  }
}
