import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/features/_base/presentation/other_parts/main_scaffold_layout.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/remote_sort_filter_controller.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/detail_summary/vn_item_detail_summary_scroll_state.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_.dart';
import 'package:vndb_lite/src/util/debouncer.dart';

part 'search_result_controller.g.dart';

@Riverpod(keepAlive: true)
class SearchResultPageController extends _$SearchResultPageController {
  @override
  int build() {
    return 1;
  }

  void increment() => state++;

  void decrement() {
    // Prevent a situation where the state is 1, and decremented into 0.
    if (state > 1) state--;
  }
}

@Riverpod(keepAlive: true)
class SearchResultController extends _$SearchResultController {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 400));

  @override
  List<VnItemGrid> build() {
    return [];
  }

  final List<String> vnId = [];

  final double limit = responsiveUI.own(0.7);

  void fromP1(List<VnDataPhase01> p1List, String labelCode) {
    for (VnDataPhase01 p1 in p1List) {
      if (vnId.contains(p1.id)) return;
      state.add(VnItemGrid(key: UniqueKey(), p1: p1, isGridView: true, labelCode: labelCode));
      vnId.add(p1.id);
    }
  }

  void handleNextResult(ScrollNotification notif) {
    // Using debouncer to debounce scrolling listener to fetch the next result if exists.
    _debouncer.call(() {
      if (notif is ScrollEndNotification) {
        if (_searchStateCanContinue &&
            ref.read(innerScrollControllerProvider)!.position.pixels >=
                (notif.metrics.maxScrollExtent - limit)) {
          // * Continue searching...
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            ref.read(searchResultPageControllerProvider.notifier).increment();
            ref.read(searchResultNotifierProvider.notifier).ring();

            await ref
                .read(searchScreenControllerProvider.notifier)
                .searchWithCurrentConf(pageResult: ref.read(searchResultPageControllerProvider));
          });
        }
      }
    });
  }

  // This ensures that search state is not either SizedBox containing loading widget, or error widget, AND
  // search filter DOES have content, NOT empty.
  bool get _searchStateCanContinue {
    final isNotScrollingInSummary = !ref.read(vnItemSummaryScrollStateProvider);
    final searchQuery = ref.read(appliedRemoteFilterControllerProvider).search;
    final searchState = ref.read(searchScreenControllerProvider);

    // Logging result.
    // debugPrint(searchState.toString());

    // Can continue if not scrolling in vn item summary, and search state is not empty,
    // have at least a result, and that result should not be a loading indicator or an error,
    // and most importantly, no empty searchQuery.
    return isNotScrollingInSummary &&
        searchState.isNotEmpty &&
        searchState.last is! SizedBox &&
        searchQuery.isNotEmpty;
  }
}
