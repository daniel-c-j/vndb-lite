// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vndb_lite/src/features/_base/domain/menu_sections.dart';
import 'package:vndb_lite/src/routing/app_router.dart';

final Map<String, MenuSections> BASE_TAB_MENU_SECTIONS = {
  AppRoute.home.name: const MenuSections(
    title: "Home",
    activeIcon: MingCute.home_4_fill,
    nonActiveIcon: MingCute.home_4_line,
  ),
  AppRoute.search.name: const MenuSections(
    title: "Search",
    activeIcon: MingCute.search_2_fill,
    nonActiveIcon: MingCute.search_2_line,
  ),
  AppRoute.collection.name: const MenuSections(
    title: "Collection",
    activeIcon: MingCute.book_2_fill,
    nonActiveIcon: MingCute.book_2_line,
  ),
  AppRoute.others.name: const MenuSections(
    title: "Others",
    activeIcon: Icons.more_horiz,
    nonActiveIcon: Icons.more_horiz,
  ),
};
