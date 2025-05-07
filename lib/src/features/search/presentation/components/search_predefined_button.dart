import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/constants/app_sizes.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/text_extensions.dart';

enum PredefinedHomeSearch {
  action("Action"),
  comedy("Comedy"),
  drama("Drama"),
  fantasy("Fantasy"),
  horror("Horror"),
  mystery("Mystery"),
  romance("Romance"),
  scifi("Sci-fi");

  const PredefinedHomeSearch(this.title);
  final String title;
}

class SearchPredefinedSection extends StatelessWidget {
  const SearchPredefinedSection({super.key});

  static final double buttonHeight = responsiveUI.own(0.15);
  static final int itemCount = PredefinedHomeSearch.values.length;
  static const int crossAxisCount = 2;
  static const double spacing = 4;

  @override
  Widget build(BuildContext context) {
    final fullHeight =
        (buttonHeight * (itemCount / crossAxisCount)) + (spacing * (itemCount / crossAxisCount));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: responsiveUI.own(0.025)),
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
                ).sizeOf(responsiveUI.catgTitle).withColor(kColor(context).tertiary),
              ],
            ),
          ),
          SizedBox(
            height: fullHeight,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: buttonHeight,
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
      ),
    );
  }
}

class SearchPredefinedButton extends StatelessWidget {
  const SearchPredefinedButton({super.key, required this.data});

  final PredefinedHomeSearch data;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      msg: "Search for ${data.title.toLowerCase()} VNs",
      onTap: () {},
      buttonColor: const Color.fromARGB(30, 255, 255, 255),
      padding: EdgeInsets.zero,
      // clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/images/search/${data.name}.jpg", fit: BoxFit.cover),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kColor(context).primary.withAlpha(120),
                  kColor(context).primary.withAlpha(60),
                  Colors.transparent,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SizedBox.expand(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(data.title).sizeOf(responsiveUI.catgTitle),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
