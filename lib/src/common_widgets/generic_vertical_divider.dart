import 'package:flutter/material.dart';

import '../util/context_shortcut.dart';

class GenericDivider extends StatelessWidget {
  const GenericDivider({super.key, this.width = 1, this.height = double.infinity, this.color});

  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: (color ?? kColor(context).tertiary).withOpacity(0.1),
          boxShadow: [
            BoxShadow(color: (color ?? kColor(context).tertiary).withOpacity(0.8), blurRadius: 5),
          ],
        ),
      ),
    );
  }
}
