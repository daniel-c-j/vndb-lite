import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/constants/app_sizes.dart';
import 'package:vndb_lite/src/core/app/navigation.dart';
import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/presentation/maintab_layout.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';
import 'package:vndb_lite/src/features/sort_filter/domain/filter_.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/remote_sort_filter_controller.dart';
import 'package:vndb_lite/src/features/sync/presentation/auth_screen_controller.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

class HomeSectionHeader extends ConsumerWidget {
  const HomeSectionHeader({super.key, required this.sectionData});

  final HomeSectionsCode sectionData;

  bool get _isCollection => sectionData == HomeSectionsCode.collection;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void seeMore(
    WidgetRef ref, {
    bool isCollection = false,
    String? sortBy,
    FilterData? filter,
  }) async {
    if (isCollection) {
      NavigationService.currentContext.goNamed(AppRoute.collection.name);
      return;
    }

    if (sortBy != null) {
      ref.read(tempRemoteSortControllerProvider.notifier).copyWith(sort: sortBy);
      ref.read(appliedRemoteSortControllerProvider.notifier).copyWith(sort: sortBy);
    }

    if (filter != null) {
      ref.read(tempRemoteFilterControllerProvider.notifier).importFilterData(filter);
      ref.read(appliedRemoteFilterControllerProvider.notifier).importFilterData(filter);
    }

    textControllerSearch.text = ' ';
    ref.read(tempRemoteFilterControllerProvider.notifier).copyWith(search: ' ');
    ref.read(appliedRemoteFilterControllerProvider.notifier).copyWith(search: ' ');

    await ref.read(searchScreenControllerProvider.notifier).searchWithCurrentConf();

    NavigationService.currentContext.goNamed(AppRoute.search.name);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _authedCollectionTitleOf(String username, BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(sectionData.icon, color: kColor(ctx).tertiary, size: responsiveUI.own(0.045)),
            GAP_W6,
            Text(username).sizeOf(responsiveUI.own(0.046)).withColor(kColor(ctx).secondary).bold,
            Text("'s").sizeOf(responsiveUI.own(0.046)).withColor(kColor(ctx).tertiary),
          ],
        ),
        Row(
          children: [
            Text(
              "Latest Collection",
            ).sizeOf(responsiveUI.catgTitle).withColor(kColor(ctx).tertiary),
          ],
        ),
      ],
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uId = ref.watch(authScreenControllerProvider);
    final userDidAuth = uId != null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(responsiveUI.own(0.025)),

            child:
                (userDidAuth && _isCollection)
                    ? _authedCollectionTitleOf(uId.username, context)
                    : Row(
                      children: [
                        Icon(
                          sectionData.icon,
                          color: kColor(context).tertiary,
                          size: responsiveUI.own(0.045),
                        ),
                        GAP_W6,
                        Text(
                          sectionData.title,
                        ).sizeOf(responsiveUI.catgTitle).withColor(kColor(context).tertiary),
                      ],
                    ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: CustomButton(
            msg: 'See More',
            onTap: () {
              seeMore(
                ref,
                filter: sectionData.filter,
                sortBy: sectionData.labelCode?.name,
                isCollection: sectionData.labelCode == SortableCode.collection,
              );
            },
            padding: const EdgeInsets.all(12),
            buttonColor: Colors.transparent,
            borderRadius: BorderRadius.circular(60),
            child: Icon(
              Icons.open_in_new,
              color: kColor(context).tertiary,
              size: responsiveUI.own(0.05),
            ),
          ),
        ),
      ],
    );
  }
}
