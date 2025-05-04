import 'package:flutter/material.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';

// TODO filter options lag.
class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required this.title, required this.isOpened, required this.onTap});

  final String title;
  final bool isOpened;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          selected: true,
          selectedTileColor: kColor(context).secondary.withOpacity(0.3),
          dense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: responsiveUI.own(0.045),
            vertical: responsiveUI.own(0.005),
          ),
          title: ShadowText(title),
          trailing: Icon(
            (isOpened) ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: kColor(context).tertiary,
            size: responsiveUI.own(0.06),
          ),
        ),
      ),
    );
  }
}
