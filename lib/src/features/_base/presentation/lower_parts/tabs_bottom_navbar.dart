import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/features/_base/domain/menu_sections.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/data/base_menu_sections.dart';
import 'package:vndb_lite/src/features/_base/presentation/lower_parts/bottom_progress_indicator_state.dart';

import '../../../../util/context_shortcut.dart';

class TabsBottomNavbar extends ConsumerWidget {
  const TabsBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.onlyProgressIndicator = false,
  });

  final int selectedIndex;
  final void Function(int)? onTap;
  final bool onlyProgressIndicator;

  static final double heightBottomNav = responsiveUI.own(0.15);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        if (!onlyProgressIndicator)
          // ScrollToHide(
          //   height: heightBottomNav,Y
          //   scrollController: controller,
          //   hideDirection: Axis.vertical,
          //   child:
          // ),
          SizedBox(
            // height: heightBottomNav,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kColor(context).primary.withAlpha(140),
                    kColor(context).primary.withAlpha(220),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(color: Color.fromARGB(150, 0, 0, 0), spreadRadius: 2, blurRadius: 6),
                ],
              ),
              child: BottomNavigationBar(
                // showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  for (MapEntry<String, MenuSections> menu in BASE_TAB_MENU_SECTIONS.entries)
                    BottomNavigationBarItem(
                      icon: Icon(menu.value.nonActiveIcon, size: responsiveUI.standardIcon),
                      activeIcon: Icon(menu.value.activeIcon, size: responsiveUI.standardIcon),
                      label: menu.value.title,
                    ),
                ],
                onTap: onTap,
                elevation: 0,
                enableFeedback: true,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedLabelStyle: styleText(
                  fontSize: responsiveUI.normalSize * 0.85,
                  fontWeight: FontWeight.bold,
                  color: kColor(context).tertiary,
                ),
                unselectedLabelStyle: styleText(
                  fontSize: responsiveUI.normalSize,
                  color: kColor(context).tertiary,
                ),
                currentIndex: selectedIndex,
                selectedFontSize: responsiveUI.normalSize,
                unselectedFontSize: responsiveUI.normalSize,
                selectedItemColor: kColor(context).secondary,
                unselectedItemColor: kColor(context).secondary.withAlpha(120),
              ),
            ),
          ),
        Consumer(
          builder: (context, ref, child) {
            if (!ref.watch(bottomProgressIndicatorProvider)) {
              return const SizedBox.shrink();
            }

            return SizedBox(
              width: kScreenWidth(context),
              height: responsiveUI.own(0.01),
              child: LinearProgressIndicator(
                backgroundColor: kColor(context).secondary,
                color: kColor(context).primary,
              ),
            );
          },
        ),
      ],
    );
  }
}
