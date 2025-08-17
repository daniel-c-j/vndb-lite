import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/common_widgets/generic_failure_connection.dart';
import 'package:vndb_lite/src/common_widgets/generic_local_empty_content.dart';
import 'package:vndb_lite/src/constants/local_db_constants.dart';
import 'package:vndb_lite/src/core/app/navigation.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/home/application/home_preview_service.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_.dart';

/// A simple horizontal-slide widget consisting a list of vn items.
class HomeSectionContent extends ConsumerWidget {
  const HomeSectionContent({super.key, required this.sectionData, this.height});

  final HomeSectionsCode sectionData;
  final double? height;

  // Height will be smaller when landscape.
  double get _sectionContentHeight {
    final context = NavigationService.currentContext;

    return (MediaQuery.of(context).orientation == Orientation.portrait)
        ? responsiveUI.own(0.485)
        : responsiveUI.own(0.45);
  }

  bool get _isCollection => sectionData.labelCode == SortableCode.collection;

  String get _previewCacheKey {
    // TODO watchout with this key, if in the future, there will be another
    // preview involving collection
    if (_isCollection) return DBKeys.COLLECTION_PREVIEW_CACHE_KEY;

    final String newTitle = sectionData.title.toUpperCase().replaceAll(' ', '-');
    return "${DBKeys.HOME_PREVIEW_CACHE_KEY}$newTitle";
  }

  Widget get _loading {
    return const Center(child: CircularProgressIndicator());
  }

  Widget get _error {
    // Exclusive for collection/local content.
    if (_isCollection) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: const GenericLocalEmptyWidget(align: TextAlign.left),
      );
    }

    return SizedBox(
      width: MediaQuery.sizeOf(NavigationService.currentContext).width * 0.9,
      child: const GenericFailureConnection(),
    );
  }

  static final cacheExtent = kScreenWidth() * 0.75;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxItem = ref.watch(settingsGeneralStateProvider).maxPreviewItem;
    final previewData = ref.watch(
      getPreviewDataProvider(
        cacheKey: _previewCacheKey,
        sectionData: sectionData,
        maxItem: maxItem,
      ),
    );

    return previewData.when(
      data: (rawData) {
        // Formatting rawData into a classified model.
        final formattedPreviewDt = ref.watch(
          formatPreviewDataProvider(rawData, cacheKey: _previewCacheKey),
        );

        return formattedPreviewDt.when(
          data: (List<VnDataPhase01> data) {
            final formattedP1Data = data;
            if (formattedP1Data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: const GenericLocalEmptyWidget(align: TextAlign.left),
              );
            }

            return SizedBox(
              height: height ?? _sectionContentHeight,
              child: ListView.builder(
                clipBehavior: Clip.none,
                cacheExtent: cacheExtent,
                scrollDirection: Axis.horizontal,
                itemCount: formattedP1Data.length,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                itemBuilder:
                    // Testing purpose
                    // (_, idx) => const SizedBox(),
                    (_, idx) => VnItemGrid(
                      p1: formattedP1Data[idx],
                      isGridView: false,
                      withLabel: false,
                      labelCode: sectionData.labelCode!.name,
                    ),
              ),
            );
          },
          error: (error, st) {
            // Logging error.
            debugPrint('Formatting data error.');
            debugPrint('${error.toString()}\n${st.toString()}');
            return _error;
          },
          loading: () => _loading,
        );
      },
      error: (error, st) {
        // Logging error.
        debugPrint('Fetching data error.');
        debugPrint('${error.toString()}\n${st.toString()}');
        return _error;
      },
      loading: () => _loading,
    );
  }
}
