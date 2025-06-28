import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/appbar_title.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_controller.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_tabs.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/home/presentation/home_appbar.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/multiselection_appbar.dart';
import 'package:vndb_lite/src/features/search/presentation/components/search_appbar.dart';

import '../../../../util/context_shortcut.dart';

/// [SliverAppBar]'s wrapper.
class TabAppBar extends ConsumerWidget {
  const TabAppBar({super.key, required this.route});

  final AppRoute route;

  static final height = responsiveUI.own(0.16);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInMultiselection = ref.watch(recordSelectedControllerProvider).isNotEmpty;

    // Hides search text field when changing screen.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (route != AppRoute.collection) {
        ref.read(showSearchTextFieldProvider.notifier).state = false;
      }
    });

    return SliverAppBar(
      elevation: 0,
      floating: true,
      toolbarHeight: height,
      forceElevated: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kColor(context).primary.withAlpha(250),
              kColor(context).primary.withAlpha(150),
            ],
          ),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(160, 0, 0, 0), spreadRadius: 2, blurRadius: 6),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      snap: (route != AppRoute.collection),
      pinned: (route == AppRoute.collection),
      title: Consumer(
        builder: (context, ref, child) {
          if (route == AppRoute.search) return const SizedBox.shrink();

          final showTextField = ref.watch(showSearchTextFieldProvider);
          if (showTextField && (route == AppRoute.collection)) return const SizedBox.shrink();

          final isInMultiselection = ref.watch(recordSelectedControllerProvider).isNotEmpty;
          if (isInMultiselection) return const SizedBox.shrink();

          return AppBarTitle(route: route);
        },
      ),
      actions: [
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        if (route == AppRoute.home) const HomeBarActions(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        if (route == AppRoute.search) const SearchBarActions(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        if (!isInMultiselection && (route == AppRoute.collection)) const CollectionBarActions(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        if (isInMultiselection && (route == AppRoute.collection)) const MultiSelectionBarActions(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
      //
      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      // Collection tab bar
      bottom: (route == AppRoute.collection) ? const CollectionAppBarTabs() : null,
    );
  }
}
