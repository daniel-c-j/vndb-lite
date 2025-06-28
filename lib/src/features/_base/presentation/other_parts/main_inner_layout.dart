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

import '../../../../util/context_shortcut.dart';

class MainInnerLayout extends StatelessWidget {
  const MainInnerLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static final bottomPadding = responsiveUI.own(0.22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColor(context).primary.withOpacity(0.1),
      body: Stack(children: [DoubleBackToClose(), navigationShell]),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          if (!App.isInCollectionScreen) return const SizedBox.shrink();

          final isInMultiSelection = ref.watch(recordSelectedControllerProvider).isNotEmpty;
          if (isInMultiSelection) return const MultiSelectFab();

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

/// A class to be used with the main scrollview widgets in a screen.
class ScrollableWrapper extends ConsumerWidget {
  const ScrollableWrapper({super.key, required this.child, this.withScrollBar = true});
  final Widget child;
  final bool withScrollBar;

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
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = ref.watch(innerSearchControllerProvider);
    // if (controller == null) return const SizedBox.shrink();

    return RefreshIndicator(
      onRefresh: () async {
        _showRefreshingSnackbar(context);
        await AppBarRefreshButton.tap();
      },
      color: kColor(context).tertiary,
      backgroundColor: kColor(context).primary.withOpacity(0.75),
      displacement: responsiveUI.own(0.02),
      strokeWidth: 2,
      child:
          (withScrollBar)
              ? RawScrollbar(
                interactive: true,
                // controller: controller,
                radius: const Radius.circular(12),
                minThumbLength: responsiveUI.own(0.1),
                crossAxisMargin: responsiveUI.own(0.01),
                thumbColor: kColor(context).secondary.withOpacity(0.9),
                child: child,
              )
              : child,
    );
  }
}
