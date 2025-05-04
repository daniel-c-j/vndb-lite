// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:vndb_lite/src/constants/conf.dart';
import 'package:vndb_lite/src/features/home/domain/home_sections_model.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';

import '../../sort_filter/domain/filter_.dart';

// ! Must convert to map to support custom section
enum HomeSectionsCode {
  collection(
    id: 1,
    title: "My Collection",
    labelCode: SortableCode.collection,
    maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
  ),
  rating(
    id: 2,
    title: "Top by Rating",
    labelCode: SortableCode.rating,
    filter: Default.REMOTE_FILTER_CONF,
    maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
  ),
  votecount(
    id: 3,
    title: "Top by Votes",
    labelCode: SortableCode.votecount,
    filter: Default.REMOTE_FILTER_CONF,
    maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
  ),
  popularOngoing(
    id: 4,
    title: "Popular Ongoing",
    labelCode: SortableCode.votecount,
    filter: FilterData(devstatus: [1]),
    maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
  );

  const HomeSectionsCode({
    required this.title,
    required this.id,
    this.labelCode,
    this.filter,
    required this.maxPreviewItem,
  });

  final String title;
  final int id;
  final SortableCode? labelCode;
  final FilterData? filter;
  final int maxPreviewItem;
}

// Using name property to retrieve the strings which can be saved in SharedPrefs (LocalDB).
// Intentional not
// final Map<String, HomePreviewSection> HOME_SCREEN_SECTIONS = {
//   HomeSectionsCode.collection.name: HomePreviewSection(
//     id: "1",
//     title: "My Collection",
//     labelCode: SortableCode.collection.name,
//     maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
//   ),
//   HomeSectionsCode.rating.name: HomePreviewSection(
//     id: "2",
//     title: "Top by Rating",
//     labelCode: SortableCode.rating.name,
//     filter: Default.REMOTE_FILTER_CONF,
//     maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
//   ),
//   HomeSectionsCode.votecount.name: HomePreviewSection(
//     id: "3",
//     title: "Top by Votes",
//     labelCode: SortableCode.votecount.name,
//     filter: Default.REMOTE_FILTER_CONF,
//     maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
//   ),
//   HomeSectionsCode.popularOngoing.name: HomePreviewSection(
//     id: "4",
//     title: "Popular Ongoing",
//     labelCode: SortableCode.votecount.name,
//     filter: Default.REMOTE_FILTER_CONF.copyWith(devstatus: [1]),
//     maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
//   ),
// };
