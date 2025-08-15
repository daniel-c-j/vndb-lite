import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection/data/collection_status_data.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';

import '../core/_core.dart';
import '../util/context_shortcut.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel({super.key, required this.labelCode, this.labelText});

  final String labelCode;
  final String? labelText;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _wrapWithPadding(Widget child) {
    return Padding(padding: EdgeInsets.only(right: responsiveUI.own(0.01)), child: child);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _shadowyImage(String imgPath) {
    return Stack(
      children: [
        Image.asset(
          imgPath,
          color: Colors.black,
          width: responsiveUI.own(0.045),
          height: responsiveUI.own(0.045),
          opacity: const AlwaysStoppedAnimation(0.4),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Image.asset(
              imgPath,
              width: responsiveUI.own(0.045),
              height: responsiveUI.own(0.045),
            ),
          ),
        ),
      ],
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget get _statusIcons {
    if (labelCode.isEmpty) return const SizedBox.shrink();

    final labelCode_ = labelCode.toLowerCase();
    final validCode =
        labelCode_ != SortableCode.title.name && COLLECTION_STATUS_DATA[labelCode_] != null;

    if (LOCAL_SORTABLE_DATA[labelCode_] != null) {
      return Icon(
        LOCAL_SORTABLE_DATA[labelCode_]!.icon,
        size: responsiveUI.own(0.04),
        color: kColor(NavigationService.currentContext).secondary,
      );
    }

    if (validCode) {
      return _shadowyImage(COLLECTION_STATUS_DATA[labelCode_]!.imagePath!);
    }

    return const SizedBox.shrink();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    if (labelCode.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.only(
        top: responsiveUI.own(0.015),
        bottom: responsiveUI.own(0.015),
        right: responsiveUI.own(0.025),
        left: responsiveUI.own(0.015),
      ),

      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kColor(context).primary.withAlpha(220), kColor(context).primary.withAlpha(160)],
        ),
        boxShadow: const [
          BoxShadow(color: Color.fromARGB(120, 0, 0, 0), spreadRadius: 4, blurRadius: 6),
        ],
      ),
      //
      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      // Icon and status label
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _wrapWithPadding(_statusIcons),
          ShadowText(
            toBeginningOfSentenceCase<String>(labelText ?? labelCode),
            color: kColor(context).secondary,
          ),
        ],
      ),
      //
      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      //
    );
  }
}
