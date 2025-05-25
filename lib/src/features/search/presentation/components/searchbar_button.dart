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
      child: CustomButton(
        onTap: () async {
          context.goNamed(AppRoute.search.name);
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            await delay(true, 350);
            focusNodeSearch.requestFocus();
          });
        },
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        elevation: 2,
        gradientColor: [kColor(context).primary.withAlpha(200), kColor(context).inverseSurface],
        child: Row(
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: kColor(context).surface.withAlpha(60),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      Text('Search for... ').wSize(responsiveUI.normalSize),
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
                    ],
                  ),
                ),
              ),
            ),
            GAP_W8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.search_rounded,
                color: kColor(context).tertiary,
                size: responsiveUI.own(0.06),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
