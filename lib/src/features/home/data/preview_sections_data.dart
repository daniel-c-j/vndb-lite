// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:vndb_lite/src/constants/conf.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';

import '../../sort_filter/domain/filter_.dart';

// ! Must convert to map to support custom section
enum HomeSectionsCode {
  rating(
    id: 2,
    title: "Top by Rating",
    labelCode: SortableCode.rating,
    filter: Default.REMOTE_FILTER_CONF,
    maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
    icon: Icons.star,
  ),
  collection(
    id: 1,
    title: "My Collection",
    labelCode: SortableCode.collection,
    maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
    icon: Icons.library_books,
  ),

  votecount(
    id: 3,
    title: "Top by Votes",
    labelCode: SortableCode.votecount,
    filter: Default.REMOTE_FILTER_CONF,
    maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
    icon: Icons.electric_bolt_outlined,
  ),
  popularOngoing(
    id: 4,
    title: "Popular Ongoing",
    labelCode: SortableCode.votecount,
    filter: FilterData(devstatus: [1]),
    maxPreviewItem: Default.MAX_PREVIEW_ITEMS_CONF,
    icon: Icons.new_releases_rounded,
  );

  const HomeSectionsCode({
    required this.title,
    required this.id,
    this.labelCode,
    this.filter,
    required this.maxPreviewItem,
    required this.icon,
  });

  final String title;
  final int id;
  final SortableCode? labelCode;
  final FilterData? filter;
  final int maxPreviewItem;
  final IconData icon;
}
