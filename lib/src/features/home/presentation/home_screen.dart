import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/constants/_constants.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_scaffold_layout.dart';
import 'package:vndb_lite/src/features/home/presentation/components/home_big_preview.dart';
import 'package:vndb_lite/src/features/search/presentation/components/search_predefined.dart';
import 'package:vndb_lite/src/features/search/presentation/components/searchbar_button.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_content.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_header.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<Widget> frontWidgets = [
    GAP_H12,
    SearchBarButton(),
    GAP_H12,
    HomeBigPreview(),
    SearchPredefinedSection(),
    GAP_H12,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);
    final controller = ref.watch(innerScrollControllerProvider);

    final additionalWidgets = [
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
    ];

    return SizedBox(
      height: kScreenHeight(context),
      child: ListView.builder(
        controller: (App.isInHomeScreen) ? controller : null,
        padding: EdgeInsets.only(bottom: MainScaffoldBody.bottomPadding),
        itemCount: frontWidgets.length + additionalWidgets.length,
        itemBuilder: (context, index) {
          return [...frontWidgets, ...additionalWidgets][index];
        },
      ),
    );
  }
}
