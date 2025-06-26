import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_scaffold_layout.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/data/base_menu_sections.dart';
import 'package:vndb_lite/src/features/_base/presentation/lower_parts/bottom_progress_indicator_state.dart';

import '../../../../util/context_shortcut.dart';
import '../other_parts/scroll_to_hide.dart';

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

  static final double heightBottomNav = responsiveUI.own(0.18);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(innerScrollControllerProvider);
    if (controller == null) return const SizedBox.shrink();

    return Stack(
      children: [
        if (!onlyProgressIndicator)
          ScrollToHide(
            height: heightBottomNav,
            scrollController: controller,
            hideDirection: Axis.vertical,
            child: SizedBox(
              height: heightBottomNav,
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
                  items: [
                    for (MapEntry<String, dynamic> menu in BASE_TAB_MENU_SECTIONS.entries)
                      BottomNavigationBarItem(
                        icon: Icon(menu.value.icon, size: responsiveUI.standardIcon),
                        label: menu.value.title,
                      ),
                  ],
                  onTap: onTap,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  selectedLabelStyle: styleText(
                    fontSize: responsiveUI.normalSize,
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
          ),
        Consumer(
          builder: (context, ref, child) {
            if (!ref.watch(bottomProgressIndicatorProvider)) {
              return const SizedBox.shrink();
            }

            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
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
