import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/generic_snackbar.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/buttons/refresh_button.dart';

import '../../../../util/context_shortcut.dart';

/// A class to be used with the main scrollview widgets in a screen.
class ScrollableWrapper extends StatelessWidget {
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

  static final double displacementPx = responsiveUI.own(0.02);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _showRefreshingSnackbar(context);
        await AppBarRefreshButton.tap();
      },
      color: kColor(context).tertiary,
      backgroundColor: kColor(context).primary.withOpacity(0.75),
      displacement: displacementPx,
      strokeWidth: 2,
      child:
          (withScrollBar)
              ? RawScrollbar(
                interactive: true,
                thickness: 6,
                mainAxisMargin: 8,
                radius: const Radius.circular(12),
                minThumbLength: responsiveUI.own(0.125),
                thumbColor: kColor(context).secondary.withOpacity(0.9),
                child: child,
              )
              : child,
    );
  }
}
