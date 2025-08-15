import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_appbar_controller.dart';
import 'package:vndb_lite/src/features/collection/presentation/collection_content_controller.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/local/local_sort_filter_controller.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/remote_sort_filter_controller.dart';
import 'package:vndb_lite/src/util/debouncer.dart';
import '../../../../util/context_shortcut.dart';

class AppBarSearchfield extends ConsumerWidget {
  const AppBarSearchfield({super.key, required this.route});
  final AppRoute route;

  static final _debouncer = Debouncer(delay: const Duration(milliseconds: 700));

  // * Intentionally made global to be easily accessing the value throughout the entire
  // * widget tree for specific and crucial use cases.
  static final controllerCollection = TextEditingController();
  static final controllerSearch = TextEditingController();
  static final focusNode = FocusNode();

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> _searchingInCollectionScreen(WidgetRef ref) async {
    ref.read(localFilterControllerProvider.notifier).copyWith(search: controllerCollection.text);

    final filterData = ref.read(localFilterControllerProvider);
    final sortData = ref.read(localSortControllerProvider);
    await ref
        .read(collectionContentControllerProvider.notifier)
        .separateVNsByStatus(filterData, sortData, searchOnly: true);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void _xButtonTap(TextEditingController controller, WidgetRef ref) {
    controller.clear();

    if (App.isInSearchScreen) {
      ref.invalidate(searchResultNotifierProvider);
      ref.read(searchScreenControllerProvider.notifier).resetState();
      ref.read(tempRemoteFilterControllerProvider.notifier).copyWith(search: "");
      ref.read(appliedRemoteFilterControllerProvider.notifier).copyWith(search: "");
      //
    } else if (App.isInCollectionScreen) {
      // The method has the same behaviour
      _searchingInCollectionScreen(ref);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = (route == AppRoute.search) ? controllerSearch : controllerCollection;

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(left: responsiveUI.own(0.055)),
        child: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, value, child) {
            return TextField(
              focusNode: (route == AppRoute.search) ? focusNode : null,
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              //
              onTapOutside: (_) {
                ref.read(showSearchTextFieldProvider.notifier).state = false;
                if (App.isInSearchScreen) focusNode.unfocus();
              },
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              //
              onSubmitted: (_) async {
                if (App.isInSearchScreen) {
                  ref
                      .read(tempRemoteFilterControllerProvider.notifier)
                      .copyWith(search: controllerSearch.text);
                  ref
                      .read(appliedRemoteFilterControllerProvider.notifier)
                      .copyWith(search: controllerSearch.text);

                  await ref.read(searchScreenControllerProvider.notifier).searchWithCurrentConf();
                }
              },
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              //
              onChanged: (_) async {
                if (App.isInCollectionScreen) {
                  _debouncer.call(() async => await _searchingInCollectionScreen(ref));
                }
              },
              //
              // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              //
              controller: controller,
              cursorColor: kColor(context).tertiary,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                hintStyle: styleText(
                  fontSize: responsiveUI.own(0.042),
                  color: kColor(context).secondary.withAlpha(180),
                ),
                fillColor: kColor(context).tertiary,
                focusColor: kColor(context).tertiary,
                // Constraints helps structure the suffix icon highlight.
                suffixIconConstraints: BoxConstraints(
                  minWidth: responsiveUI.own(0.1),
                  minHeight: responsiveUI.own(0.1),
                ),
                suffixIcon:
                    controller.text.isNotEmpty
                        ? Padding(
                          padding: EdgeInsets.only(
                            // bottom: responsiveUI.own(0.01),
                            right: responsiveUI.own(0.02),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            onTap: () {
                              _xButtonTap(controller, ref);
                            },
                            child: Icon(
                              Icons.clear,
                              color: kColor(context).tertiary,
                              size: responsiveUI.own(0.055),
                            ),
                          ),
                        )
                        : null,
              ),
              style: styleText(fontSize: responsiveUI.own(0.042)),
            );
          },
        ),
      ),
    );
  }
}
