import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/constants/_constants.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_inner_layout.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/tabs_sliver_appbar.dart';
import 'package:vndb_lite/src/features/home/presentation/components/home_big_preview.dart';
import 'package:vndb_lite/src/features/search/presentation/components/search_predefined.dart';
import 'package:vndb_lite/src/features/search/presentation/components/searchbar_button.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_content.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_header.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/routing/app_router.dart';

import '../../_base/presentation/other_parts/main_inner_layout.dart';

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
    final additionalWidgets = [
      for (HomeSectionsCode sectionCode in Default.HOME_SECTION_ARRANGEMENT)
        Column(
          key: ValueKey(sectionCode),
          mainAxisSize: MainAxisSize.min,
          children: [
            HomeSectionHeader(sectionData: sectionCode),
            HomeSectionContent(sectionData: sectionCode, maxItem: settings.maxPreviewItem),
            GAP_H12,
          ],
        ),
    ];

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (_, __) => const [TabAppBar(route: AppRoute.home)],
      body: ScrollableWrapper(withScrollBar: false,child:ListView.builder(
        // controller: controller,
        padding: EdgeInsets.only(bottom: MainInnerLayout.bottomPadding),
        itemCount: frontWidgets.length + additionalWidgets.length,
        itemBuilder: (context, index) {
          return [...frontWidgets, ...additionalWidgets][index];
        },
      ),),
    );
  }
}
