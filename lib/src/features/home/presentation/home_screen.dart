import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/features/home/presentation/components/home_big_preview.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_content.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_header.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);

    return Column(
      children: [
        for (HomeSectionsCode sectionCode in settings.homeSectionsArrangement)
          Padding(
            padding:
                (sectionCode == HomeSectionsCode.rating)
                    ? EdgeInsets.only(bottom: responsiveUI.own(0.04))
                    : EdgeInsets.only(
                      left: responsiveUI.own(0.04),
                      right: responsiveUI.own(0.04),
                      bottom: responsiveUI.own(0.04),
                    ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kColor(context).primary.withAlpha(200), kColor(context).inverseSurface],
                ),
                borderRadius:
                    (sectionCode == HomeSectionsCode.rating)
                        ? BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        )
                        : BorderRadius.circular(16),
                boxShadow: const [BoxShadow(blurRadius: 1, color: Color.fromARGB(180, 0, 0, 0))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                key: ValueKey(sectionCode),
                children: [
                  if (sectionCode == HomeSectionsCode.rating) ...const [
                    HomeBigPreview(),
                    Divider(height: 0, thickness: 0.5),
                  ],
                  HomeSectionHeader(sectionData: sectionCode),
                  HomeSectionContent(
                    sectionData: sectionCode,
                    maxItem: settings.maxPreviewItem,
                    height:
                        (sectionCode == HomeSectionsCode.rating) ? responsiveUI.own(0.525) : null,
                  ),
                  SizedBox(height: responsiveUI.own(0.03)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
