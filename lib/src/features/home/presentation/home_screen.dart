import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/common_widgets/bbcode.dart';
import 'package:vndb_lite/src/constants/_constants.dart';
import 'package:vndb_lite/src/features/_base/presentation/main_outer_layout.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_inner_layout.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/tabs_sliver_appbar.dart';
import 'package:vndb_lite/src/features/random/presentation/random_preview.dart';
import 'package:vndb_lite/src/features/search/presentation/components/search_predefined.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_content.dart';
import 'package:vndb_lite/src/features/home/presentation/components/section_header.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/responsive.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<Widget> frontWidgets = [
    GAP_H20,
    RandomPreview(),
    GAP_H4,
    HomeSectionHeader(sectionData: HomeSectionsCode.rating),
    HomeSectionContent(
      key: ValueKey(HomeSectionsCode.rating),
      sectionData: HomeSectionsCode.rating,
    ),
    GAP_H12,
    SearchPredefinedSection(),
    GAP_H12,
  ];

  static final double _sectionContentHeight = responsiveUI.own(0.45);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final additionalWidgets = <Widget>[
      for (HomeSectionsCode sectionCode in Default.HOME_SECTION_ARRANGEMENT)
        // ? Rating has special place.
        if (sectionCode != HomeSectionsCode.rating) ...[
          HomeSectionHeader(sectionData: sectionCode),
          HomeSectionContent(
            key: ValueKey(sectionCode),
            sectionData: sectionCode,
            height: _sectionContentHeight,
          ),
          GAP_H12,
        ],
    ];

    // return CustomScrollView(slivers: [SliverAppBar(), SliverToBoxAdapter(child: Container())]);

    return NestedScrollView(
      // headerSliverBuilder: (_, _) => const [SliverAppBar()],
      headerSliverBuilder: (_, _) => const [TabAppBar(route: AppRoute.home)],
      // body: Container(),
      body: ScrollableWrapper(
        withScrollBar: false,
        child: ListView.builder(
          shrinkWrap: false,
          clipBehavior: Clip.none,
          padding: EdgeInsets.only(bottom: MainOuterLayout.bottomPadding),
          itemCount: frontWidgets.length + additionalWidgets.length,
          itemBuilder: (context, index) {
            return [...frontWidgets, ...additionalWidgets][index];
          },
        ),
      ),
    );
  }
}
