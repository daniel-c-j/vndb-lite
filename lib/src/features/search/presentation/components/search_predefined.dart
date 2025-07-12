import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/constants/app_sizes.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/appbar_searchfield.dart';
import 'package:vndb_lite/src/features/search/presentation/search_screen_controller.dart';
import 'package:vndb_lite/src/features/sort_filter/domain/filter_.dart';
import 'package:vndb_lite/src/features/sort_filter/domain/sort_.dart';
import 'package:vndb_lite/src/features/sort_filter/presentation/remote/remote_sort_filter_controller.dart';
import 'package:vndb_lite/src/features/vn/domain/others.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

enum PredefinedHomeSearch {
  action(VnTag(id: "g12", name: "Action")),
  comedy(VnTag(id: "g104", name: "Comedy")),
  drama(VnTag(id: "g147", name: "Drama")),
  fantasy(VnTag(id: "g2", name: "Fantasy")),
  horror(VnTag(id: "g7", name: "Horror")),
  mystery(VnTag(id: "g19", name: "Mystery")),
  romance(VnTag(id: "g96", name: "Romance")),
  scifi(VnTag(id: "g105", name: "Sci-fi"));

  const PredefinedHomeSearch(this.tag);
  final VnTag tag;

  String get path => "assets/images/search/$name.png";
}

class SearchPredefinedSection extends StatelessWidget {
  const SearchPredefinedSection({super.key});

  static final double buttonHeight = responsiveUI.own(0.15);
  static final double buttonWidth = responsiveUI.own(0.4);
  static final int itemCount = PredefinedHomeSearch.values.length;
  static const int crossAxisCount = 2;
  static const double spacing = 8;

  static final fullHeight =
      (buttonHeight * (itemCount / crossAxisCount)) + (spacing * (itemCount / crossAxisCount));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: responsiveUI.own(0.025)),
          child: Row(
            children: [
              Icon(
                Icons.theater_comedy_rounded,
                color: kColor(context).tertiary,
                size: responsiveUI.own(0.045),
              ),
              GAP_W6,
              Text(
                "Explore general genres",
              ).wSize(responsiveUI.catgTitle).wColor(kColor(context).tertiary),
            ],
          ),
        ),
        SizedBox(
          height: fullHeight / 2,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: buttonHeight,
              mainAxisExtent: buttonWidth,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              final predefinedSearch = PredefinedHomeSearch.values[index];
              return SearchPredefinedButton(data: predefinedSearch);
            },
          ),
        ),
      ],
    );
  }
}

class SearchPredefinedButton extends ConsumerWidget {
  const SearchPredefinedButton({super.key, required this.data});

  final PredefinedHomeSearch data;

  static const searchSortConf = SortData(sort: null);
  static const double radius = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            boxShadow: const [
              BoxShadow(blurRadius: 2, offset: Offset(0, 2), color: Color.fromARGB(120, 0, 0, 0)),
            ],
          ),
          child: SizedBox.expand(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.asset(data.path, fit: BoxFit.cover),
            ),
          ),
        ),
        CustomButton(
          msg: "Search for ${data.tag.name!.toLowerCase()} VNs",
          onTap: () async {
            final filter = FilterData(search: ' ', tag: [data.tag]);

            ref.read(tempRemoteSortControllerProvider.notifier).importSortData(searchSortConf);
            ref.read(appliedRemoteSortControllerProvider.notifier).importSortData(searchSortConf);

            AppBarSearchfield.controllerSearch.text = ' ';
            ref.read(tempRemoteFilterControllerProvider.notifier).importFilterData(filter);
            ref.read(appliedRemoteFilterControllerProvider.notifier).importFilterData(filter);

            await ref.read(searchScreenControllerProvider.notifier).searchWithCurrentConf();
            context.goNamed(AppRoute.search.name);
          },
          padding: EdgeInsets.zero,
          gradientColor: [
            kColor(context).primary.withAlpha(150),
            kColor(context).primary.withAlpha(90),
            Colors.transparent,
          ],
          gradientStart: Alignment.centerLeft,
          gradientEnd: Alignment.centerRight,
          borderRadius: BorderRadius.circular(radius),
          child: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(data.tag.name!).wSize(responsiveUI.own(0.0475)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
