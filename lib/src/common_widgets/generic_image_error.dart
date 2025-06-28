import 'package:flutter/material.dart';
import 'package:vndb_lite/src/util/responsive.dart';

class GenericErrorImage extends StatelessWidget {
  const GenericErrorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: responsiveUI.own(0.025)),
      margin: EdgeInsets.symmetric(horizontal: responsiveUI.own(0.05)),
      alignment: Alignment.center,
      child: SizedBox(
        width: responsiveUI.own(0.22),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              size: 34,
              color: Color.fromARGB(200, 168, 168, 168),
              shadows: [Shadow(color: Color.fromARGB(150, 0, 0, 0), blurRadius: 4)],
            ),
            // Text(
            //   'Error Image',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: responsiveUI.normalSize,
            //     color: Colors.red,
            //     shadows: const [Shadow(color: Colors.black, blurRadius: 5)],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
