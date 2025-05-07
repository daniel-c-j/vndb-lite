import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/double_back_to_close.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/buttons/refresh_button.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/fab/multi_select_fab.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/remote_sort_filter_controller.dart';
import 'package:vndb_lite/src/util/balanced_safearea.dart';

import '../../../../util/context_shortcut.dart';

final innerScrollControllerProvider = StateProvider<ScrollController?>((ref) {
  return;
});

class MainScaffoldBody extends StatelessWidget {
  const MainScaffoldBody({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  bool _showScrollBar(WidgetRef ref) {
    final remoteSearch = ref.read(appliedRemoteFilterControllerProvider).search;
    if (App.isInCollectionScreen) return true;
    if (App.isInSearchScreen && remoteSearch.isNotEmpty) {
      return true;
    }

    return false;
  }

  void _showRefreshingSnackbar(BuildContext ctx) {
    GenericSnackBar(
      duration: const Duration(milliseconds: 2500),
      content: [
        Icon(Icons.refresh, color: kColor(ctx).tertiary, size: responsiveUI.snackbarIcon),
        SizedBox(width: responsiveUI.own(0.015)),
        ShadowText('Refreshing...', fontSize: responsiveUI.snackbarTxt),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final scrollBarColor = kColor(context).secondary.withOpacity(0.9);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Do not use const.
          DoubleBackToClose(),
          RefreshIndicator(
            onRefresh: () async {
              _showRefreshingSnackbar(context);
              await AppBarRefreshButton.tap();
            },
            color: kColor(context).tertiary,
            backgroundColor: kColor(context).primary.withOpacity(0.75),
            displacement: responsiveUI.own(0.02),
            strokeWidth: 2,
            child: Consumer(
              builder: (context, ref, child) {
                final controller = ref.watch(innerScrollControllerProvider);
                final showScrollBar = _showScrollBar(ref);

                if (controller == null) return const SizedBox.shrink();

                return RawScrollbar(
                  interactive: showScrollBar,
                  controller: controller,
                  radius: const Radius.circular(12),
                  minThumbLength: responsiveUI.own(0.1),
                  crossAxisMargin: measureSafeAreaOf(responsiveUI.own(0.01)),
                  thumbColor: (showScrollBar) ? scrollBarColor : Colors.transparent,
                  child: SingleChildScrollView(
                    controller: controller,
                    padding: EdgeInsets.only(bottom: responsiveUI.own(0.2)),
                    // * The real content
                    child: navigationShell,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final isInMultiSelection = ref.watch(recordSelectedControllerProvider).isNotEmpty;

          if (isInMultiSelection) return const MultiSelectFab();
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
