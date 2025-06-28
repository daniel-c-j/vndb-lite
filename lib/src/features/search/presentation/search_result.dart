import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/search/presentation/search_result_controller.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../_base/presentation/other_parts/main_scaffold_layout.dart';

/// A class to display pure search result (No error, no loading).
/// The heart of this class is searchResultControllerProvider that provides this class's content.
class SearchResult extends ConsumerWidget {
  const SearchResult({super.key});

  void _forceUpdateUI() {
    SchedulerBinding.instance.addPersistentFrameCallback((_) {
      if (!App.isInSearchScreen) return;
      ref_.read(searchResultNotifierProvider.notifier).ring();
      ref_.read(searchResultNotifierProvider.notifier).end();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsGeneralStateProvider);
    final searchResult = ref.watch(searchResultControllerProvider);
    final searchNotify = ref.watch(searchResultNotifierProvider);

    // To forcefully update the widget
    if (searchNotify && context.mounted) _forceUpdateUI();

    final controller = ref.watch(innerScrollControllerProvider);
    return Padding(
      padding: EdgeInsets.only(top: responsiveUI.own(0.04)),
      child: SizedBox(
        height: kScreenHeight(context),
        child: MasonryGridView.builder(
          controller: controller,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? settings.maxItemPerRowPortrait
                    : settings.maxItemPerRowLandscape,
          ),
          mainAxisSpacing: responsiveUI.own(0.03),
          crossAxisSpacing: responsiveUI.own(0.005),
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          itemCount: searchResult.length,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            if (index + 1 == searchResult.length) {
              return Padding(
                padding: EdgeInsets.only(bottom: MainScaffoldBody.bottomPadding),
                child: searchResult[index],
              );
            }

            return searchResult[index];
          },
        ),
      ),
    );

    // return Padding(
    //   padding: EdgeInsets.only(top: responsiveUI.own(0.04)),
    //   child: MasonryGrid(
    //     staggered: true,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisSpacing: responsiveUI.own(0.03),
    //     column:
    //         (MediaQuery.of(context).orientation == Orientation.portrait)
    //             ? settings.maxItemPerRowPortrait
    //             : settings.maxItemPerRowLandscape,
    //     children: searchResult,
    //   ),
    // );
  }
}
