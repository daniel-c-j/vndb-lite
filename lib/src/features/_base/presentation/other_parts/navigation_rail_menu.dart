import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/data/base_menu_sections.dart';

import '../../../../util/context_shortcut.dart';

class TabsSideNavbar extends StatelessWidget {
  const TabsSideNavbar({super.key, required this.selectedIndex, required this.onTap});

  final int selectedIndex;
  final void Function(int)? onTap;

  static final double widthSideNav = responsiveUI.own(0.23);

  @override
  Widget build(BuildContext context) {
    // Only shows in landscape mode
    return Row(
      children: [
        Container(
          // While the other safeAreaMeasured widgets need to be decreased in size when
          // there's a safeArea, this particular widget, needs to be increased instead,
          // that's why its incrementing the original size with the safeArea size.
          width: widthSideNav,

          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                kColor(context).primary.withAlpha(140),
                kColor(context).primary.withAlpha(220),
              ],
            ),
            boxShadow: const [
              BoxShadow(color: Color.fromARGB(150, 0, 0, 0), spreadRadius: 2, blurRadius: 6),
            ],
          ),
          child: NavigationRail(
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            selectedLabelTextStyle: styleText(
              fontSize: responsiveUI.normalSize,
              fontWeight: FontWeight.bold,
              color: kColor(context).tertiary,
            ),
            unselectedLabelTextStyle: styleText(
              fontSize: responsiveUI.normalSize,
              color: kColor(context).tertiary,
            ),
            selectedIconTheme: IconThemeData(color: kColor(context).secondary),
            unselectedIconTheme: IconThemeData(color: kColor(context).secondary.withAlpha(120)),
            selectedIndex: selectedIndex,
            onDestinationSelected: onTap,
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (MapEntry<String, dynamic> menu in BASE_TAB_MENU_SECTIONS.entries)
                NavigationRailDestination(
                  icon: Icon(menu.value.icon, size: responsiveUI.standardIcon),
                  label: Text(menu.value.title),
                ),
            ],
          ),
        ),
        const VerticalDivider(thickness: 0, width: 0),
      ],
    );
  }
}
