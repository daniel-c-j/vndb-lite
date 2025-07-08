import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';

/// [DoubleBackToCloseApp]'s wrapper. Cannot be const due to the app's structure relying on
/// globally-shared routing state.
class DoubleBackToClose extends ConsumerWidget {
  // ignore: prefer_const_constructors_in_immutables
  DoubleBackToClose({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only quits when in multiselection and hitting back button.
    final isInMultiselection = ref.watch(recordSelectedControllerProvider).isNotEmpty;

    return DoubleBackToCloseApp(
      snackBar: GenericSnackBar.buildSnackBar(
        children: [
          // Do not show any snackbar when tapping back button in multiselection.
          if (!isInMultiselection)
            Flexible(
              child: ShadowText(
                'Please tap back again to exit',
                fontSize: responsiveUI.snackbarTxt,
              ),
            ),
        ],
        duration: Duration(milliseconds: (!isInMultiselection) ? 4000 : 200),
      ),
      child: const SizedBox.shrink(),
    );
  }
}
