import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/constants/_constants.dart';
import 'package:vndb_lite/src/util/responsive.dart';

class VnItemDetailTitle extends StatelessWidget {
  const VnItemDetailTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 0, 0, 0),
              offset: Offset(0, 30),
              spreadRadius: 20,
              blurRadius: 35,
            ),
          ],
        ),
        child: Text(
          title,
          maxLines: 2,
          softWrap: true,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: styleText(fontSize: responsiveUI.normalSize, color: Colors.white),
        ),
      ),
    );
  }
}

class VnItemDetailTitlePlus extends StatelessWidget {
  const VnItemDetailTitlePlus({
    super.key,
    required this.title,
    required this.desc,
    required this.additionalWidget,
  });

  final String title;
  final String desc;
  final Widget additionalWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(180, 0, 0, 0),
              offset: Offset(0, 30),
              spreadRadius: 20,
              blurRadius: 35,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                maxLines: 2,
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: styleText(
                  fontSize: responsiveUI.catgTitle * 1.25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GAP_H4,
              Text(
                desc.replaceAll(RegExp(r'[\r\n]+'), " "), // Replace breaklines into just space.
                maxLines: 3,
                softWrap: true,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: styleText(
                  fontSize: responsiveUI.normalSize,
                  color: Colors.white.withAlpha(220),
                ),
              ),
              GAP_H4,
              additionalWidget,
            ],
          ),
        ),
      ),
    );
  }
}
