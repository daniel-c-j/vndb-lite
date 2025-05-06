import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/common_widgets/generic_failure_connection.dart';
import 'package:vndb_lite/src/common_widgets/generic_local_empty_content.dart';
import 'package:vndb_lite/src/constants/local_db_constants.dart';
import 'package:vndb_lite/src/core/app/navigation.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/home/application/home_preview_service.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_.dart';

final homeRatingPreviewsProvider = StateProvider<List<VnDataPhase01>>((ref) => const []);

/// A simple horizontal-slide widget consisting a list of vn items.
class HomeSectionContent extends ConsumerWidget {
  const HomeSectionContent({
    super.key,
    required this.sectionData,
    required this.maxItem,
    this.height,
  });

  final HomeSectionsCode sectionData;
  final int maxItem;
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
    if (_isCollection) return GenericLocalEmptyWidget();

    return SizedBox(
      width: MediaQuery.sizeOf(NavigationService.currentContext).width * 0.9,
      child: const GenericFailureConnection(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            if (formattedP1Data.isEmpty) return const GenericLocalEmptyWidget();

            SchedulerBinding.instance.addPostFrameCallback((_) {
              if (sectionData != HomeSectionsCode.rating) return;
              ref.read(homeRatingPreviewsProvider.notifier).state = data;
            });

            return SizedBox(
              height: height ?? _sectionContentHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: formattedP1Data.length,
                itemBuilder:
                    (_, idx) => Padding(
                      padding: EdgeInsets.only(
                        left: (idx == 0) ? 6.0 : 0,
                        right: (idx == formattedP1Data.length - 1) ? 6.0 : 0,
                      ),
                      child: VnItemGrid(
                        key: UniqueKey(),
                        p1: formattedP1Data[idx],
                        isGridView: false,
                        labelCode: sectionData.labelCode!.name,
                      ),
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
