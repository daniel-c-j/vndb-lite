import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/app.dart';
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

class TabAppBar extends ConsumerWidget {
  const TabAppBar({super.key});

  static final height = responsiveUI.own(0.16);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInMultiselection = ref.watch(recordSelectedControllerProvider).isNotEmpty;

    // Hides search text field when changing screen.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!App.isInCollectionScreen && context.mounted) {
        ref.read(showSearchTextFieldProvider.notifier).state = false;
      }
    });

    return SliverAppBar(
      elevation: 0,
      floating: true,
      toolbarHeight: height,
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
      snap: !App.isInCollectionScreen,
      pinned: App.isInCollectionScreen,
      title: Consumer(
        builder: (context, ref, child) {
          final isInMultiselection = ref.watch(recordSelectedControllerProvider).isNotEmpty;
          final showTextField = ref.watch(showSearchTextFieldProvider);

          if (App.isInSearchScreen || isInMultiselection) return const SizedBox.shrink();
          if (showTextField && App.isInCollectionScreen) return const SizedBox.shrink();

          // No const yet.
          return AppbarTitle();
        },
      ),
      actions: [
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        if (App.isInHomeScreen) const HomeBarActions(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        if (App.isInSearchScreen) const SearchBarActions(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        if (!isInMultiselection && App.isInCollectionScreen) const CollectionBarActions(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        if (isInMultiselection && App.isInCollectionScreen) const MultiSelectionBarActions(),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
      //
      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      // Collection tab bar
      bottom: (App.isInCollectionScreen) ? const CollectionAppbarTabs() : null,
    );
  }
}
