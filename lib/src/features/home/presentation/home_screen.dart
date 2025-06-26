import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/constants/_constants.dart';
import 'package:vndb_lite/src/features/home/presentation/components/home_big_preview.dart';
import 'package:vndb_lite/src/features/search/presentation/components/search_predefined.dart';
import 'package:vndb_lite/src/features/search/presentation/components/searchbar_button.dart';
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
        GAP_H12,
        const SearchBarButton(),
        GAP_H12,
        const HomeBigPreview(),
        const SearchPredefinedSection(),
        GAP_H12,
        for (HomeSectionsCode sectionCode in settings.homeSectionsArrangement)
          Column(
            mainAxisSize: MainAxisSize.min,
            key: ValueKey(sectionCode),
            children: [
              HomeSectionHeader(sectionData: sectionCode),
              HomeSectionContent(sectionData: sectionCode, maxItem: settings.maxPreviewItem),
              GAP_H12,
            ],
          ),
      ],
    );
  }
}
