import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/constants/app_sizes.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/home/presentation/section/section_content.dart';
import 'package:vndb_lite/src/features/home/presentation/section/section_header.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);

    return Padding(
      padding: EdgeInsets.only(left: responsiveUI.own(0.04), right: responsiveUI.own(0.04)),
      child: Column(
        children: [
          const SizedBox(height: Sizes.P16),
          for (HomeSectionsCode sectionCode in settings.homeSectionsArrangement)
            Padding(
              padding: EdgeInsets.only(bottom: responsiveUI.own(0.04)),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kColor(context).primary.withAlpha(200),
                      kColor(context).inverseSurface,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(blurRadius: 1, color: Color.fromARGB(180, 0, 0, 0))],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  key: ValueKey(sectionCode),
                  children: [
                    HomeSectionHeader(sectionData: sectionCode),
                    HomeSectionContent(sectionData: sectionCode, maxItem: settings.maxPreviewItem),
                    const SizedBox(height: Sizes.P12),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
