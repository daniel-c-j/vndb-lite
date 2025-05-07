import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/constants/app_sizes.dart';
import 'package:vndb_lite/src/features/_base/presentation/maintab_layout.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/delay.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

class SearchBarButton extends StatelessWidget {
  const SearchBarButton({super.key});

  static List<String> searchPlaceholder = [
    "Fate series",
    "Steins gate",
    "Samurai stuff",
    "I don't know",
    "Tomboy GF",
    "Older heroine",
    "Nakige",
    "Parody",
    "Sad stuff",
    "Childhood friends",
    "The meaning of life",
    "Vtuber feet",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: responsiveUI.own(0.025)),
            child: Row(
              children: [
                Icon(Icons.search, color: kColor(context).tertiary, size: responsiveUI.own(0.045)),
                GAP_W6,
                Text(
                  "Quick search",
                ).sizeOf(responsiveUI.catgTitle).withColor(kColor(context).tertiary),
              ],
            ),
          ),
          CustomButton(
            onTap: () async {
              context.goNamed(AppRoute.search.name);
              SchedulerBinding.instance.addPostFrameCallback((_) async {
                await delay(true, 350);
                focusNodeSearch.requestFocus();
              });
            },
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            elevation: 2,
            gradientColor: [kColor(context).primary.withAlpha(200), kColor(context).inverseSurface],
            child: Row(
              children: [
                Text('Search for... ').sizeOf(responsiveUI.normalSize),
                Expanded(
                  child: IgnorePointer(
                    ignoring: true,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        for (String text in searchPlaceholder)
                          TypewriterAnimatedText(
                            text,
                            textStyle: TextStyle(fontSize: responsiveUI.normalSize),
                            speed: const Duration(milliseconds: 100),
                            cursor: '|',
                          ),
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 1000),
                    ),
                  ),
                ),
                Icon(
                  Icons.search_rounded,
                  color: kColor(context).tertiary,
                  size: responsiveUI.own(0.0475),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
