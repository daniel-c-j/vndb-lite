import 'package:flutter/material.dart';
import 'package:vndb_lite/src/util/responsive.dart';

class SearchPredefinedButton extends StatelessWidget {
  const SearchPredefinedButton({super.key});

  static final double buttonHeight = responsiveUI.own(0.125);
  static const int itemCount = 8;
  static const int crossAxisCount = 2;
  static const double spacing = 4;

  @override
  Widget build(BuildContext context) {
    final fullHeight =
        (buttonHeight * (itemCount / crossAxisCount)) + (spacing * (itemCount / crossAxisCount));

    return SizedBox(
      height: fullHeight,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisExtent: buttonHeight,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
        ),
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(color: Colors.white);
        },
      ),
    );
  }
}
