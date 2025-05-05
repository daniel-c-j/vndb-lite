import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/masonry_grid.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/search/presentation/search_result_controller.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';

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

    return Padding(
      padding: EdgeInsets.only(top: responsiveUI.own(0.04)),
      child: MasonryGrid(
        staggered: true,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSpacing: responsiveUI.own(0.03),
        column:
            (MediaQuery.of(context).orientation == Orientation.portrait)
                ? settings.maxItemPerRowPortrait
                : settings.maxItemPerRowLandscape,
        children: searchResult,
      ),
    );
  }
}
