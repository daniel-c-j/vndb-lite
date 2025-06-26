import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/delay.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/sort_filter/data/others/languages.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';
import 'package:vndb_lite/src/features/vn/domain/p2.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/util/language_code_formatting.dart';

class VnDetailReleasesLang extends StatelessWidget {
  const VnDetailReleasesLang({super.key, required this.p1, required this.p2});

  final VnDataPhase01 p1;
  final VnDataPhase02 p2;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<Widget> get _flagWidgets async {
    final List<Widget> languageData = [];

    for (String language in (p2.languages ?? [])) {
      // Original language will be processed later on.
      if (language != p1.olang) {
        languageData.add(_flagLangCode(language));
      }
    }

    for (String language in (p2.mtl ?? [])) {
      languageData.add(_flagLangCode(language, txt: '(Machine Translation)'));
    }

    await delay(true, 1200);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: languageData);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _flagLangCode(String langCode, {String txt = ''}) {
    //
    return Padding(
      padding: EdgeInsets.only(bottom: responsiveUI.own(0.01)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flag.fromString(
            formatLanguageCode(languageCode: langCode),
            height: responsiveUI.own(0.038),
            width: responsiveUI.own(0.055),
            fit: BoxFit.fill,
            borderRadius: 3,
          ),
          ShadowText('  ${LanguageLocal.getDisplayLanguage(langCode)!['name']} $txt'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadowText('Languages', fontSize: responsiveUI.own(0.045), fontWeight: FontWeight.bold),
        SizedBox(height: responsiveUI.own(0.01)),
        Row(
          children: [
            _flagLangCode(p1.olang!),
            ShadowText(
              ' (Origin)',
              fontWeight: FontWeight.bold,
              fontSize: responsiveUI.normalSize,
              color: kColor(context).secondary,
              shadows: [
                Shadow(
                  color: Color.alphaBlend(Colors.black.withOpacity(0.5), kColor(context).primary),
                  blurRadius: 15,
                ),
              ],
            ),
          ],
        ),
        FutureBuilder(
          future: _flagWidgets,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.all(responsiveUI.own(0.3)),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final flags = snapshot.data;
            return flags;
          },
        ),
      ],
    );
  }
}
