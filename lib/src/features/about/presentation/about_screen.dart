import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vndb_lite/src/common_widgets/custom_label.dart';
import 'package:vndb_lite/src/common_widgets/generic_background.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/constants/app_info.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/util/balanced_safearea.dart';

import '../../../common_widgets/custom_button.dart';
import '../../../util/context_shortcut.dart';
import '../../theme/theme_data_provider.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  static const List<String> oreNoPassion = ["Mobile Development", "Cybersecurity", "Literature"];

  static final Map<String, dynamic> contacts = {
    "email": {
      "urlDomain": "mailto:",
      "id": [
        // "daniel_cj@mail2tor.com", // Alternate
        "dcj.dandy800@passinbox.com",
      ],
      "icon": Icon(Icons.email, size: responsiveUI.own(0.05), color: kColor().tertiary),
    },
    "github": {
      "urlDomain": "https://github.com/",
      "id": ["Daniel-C-J"],
      "icon": Image.asset(
        'assets/images/contact/github.png',
        fit: BoxFit.cover,
        width: responsiveUI.own(0.05),
        color: kColor().tertiary,
      ),
    },
    "codeberg": {
      "urlDomain": "https://codeberg.org/",
      "id": ["daniel-c-j"],
      "icon": Image.asset(
        'assets/images/contact/codeberg.png',
        fit: BoxFit.cover,
        width: responsiveUI.own(0.05),
        color: kColor().tertiary,
      ),
    },
    "ko-fi": {
      "urlDomain": "https://ko-fi.com/",
      "id": ["danielcj"],
      "icon": Image.asset(
        'assets/images/contact/ko-fi.webp',
        fit: BoxFit.cover,
        width: responsiveUI.own(0.05),
      ),
    },
  };

  String get _passions {
    final String passion = oreNoPassion.getRange(0, oreNoPassion.length - 1).join(", ");
    return "$passion, and ${oreNoPassion.last}";
  }

  String _getUrlDomain(contactType, id) {
    return "${contacts[contactType]["urlDomain"]}$id".trim();
  }

  Widget _getContactWidget({required String urlLink, required List<Widget> contents}) {
    return Padding(
      padding: EdgeInsets.all(responsiveUI.own(0.02)),
      child: Tooltip(
        message: urlLink,
        child: CustomLabel(
          useBorder: false,
          padding: EdgeInsets.symmetric(
            horizontal: responsiveUI.own(0.03),
            vertical: responsiveUI.own(0.02),
          ),
          onTap: () {
            final url = urlLink.trim();
            launchUrlString(url);
          },
          children: contents,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateProvider);

    return Scaffold(
      backgroundColor: kColor(context).primary.withOpacity(0.3),
      body: Stack(
        children: [
          GenericBackground(imagePath: theme.backgroundImgPath, useGradientOverlay: true),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              right: measureSafeAreaOf(responsiveUI.own(0.05)),
              left: measureSafeAreaOf(responsiveUI.own(0.05)),
              bottom: responsiveUI.own(0.2),
            ),
            child: Column(
              children: [
                //
                // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                // App icon
                Tooltip(
                  message: 'Christiane Friedrich from Majikoi Series ♥',
                  margin: EdgeInsets.only(top: responsiveUI.own(0.12)),
                  preferBelow: true,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: responsiveUI.own(0.3),
                      bottom: responsiveUI.own(0.02),
                    ),
                    width: responsiveUI.own(0.25),
                    height: responsiveUI.own(0.25),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kColor(context).secondary.withOpacity(0.4),
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Image.asset('assets/images/icon/app_icon.png', fit: BoxFit.cover),
                  ),
                ),
                //
                // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                //
                ShadowText(
                  AppInfo.TITLE,
                  fontSize: responsiveUI.own(0.05),
                  fontWeight: FontWeight.bold,
                  align: TextAlign.center,
                ),
                ShadowText('ver ${AppInfo.CURRENT_VERSION}', align: TextAlign.center),
                ShadowText(AppInfo.DESCRIPTION, align: TextAlign.center),
                Divider(indent: responsiveUI.own(0.1), endIndent: responsiveUI.own(0.1)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: responsiveUI.own(0.02)),
                  child: ShadowText('About', fontSize: responsiveUI.catgTitle),
                ),
                ShadowText(
                  "Hi there, Daniel CJ here. I am the developer of this app, ${AppInfo.TITLE}. "
                  "I am passionated about $_passions. "
                  "\n\n"
                  "This is the first Flutter app I've ever developed. "
                  "It took me about 8 ~ 9 weeks to finish the first version of this app. "
                  "At first it was just a sudden idea that popped in my head out of nowhere, but it ended up "
                  "as what you are using now. I am certainly grateful for this wonderful experience "
                  "of developing a mobile app using Flutter, and looking to develop more!",
                  align: TextAlign.center,
                ),
                Divider(indent: responsiveUI.own(0.1), endIndent: responsiveUI.own(0.1)),
                Container(
                  margin: EdgeInsets.only(
                    top: responsiveUI.own(0.02),
                    bottom: responsiveUI.own(0.02),
                  ),
                  child: ShadowText('Contact', fontSize: responsiveUI.catgTitle),
                ),
                //
                // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                // Contact
                ShadowText(
                  'Project? Job offer?... Or feeling generous enough to donate to me? :) '
                  'Check out my contact info right below:',
                  align: TextAlign.center,
                ),
                SizedBox(height: responsiveUI.own(0.02)),
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    //
                    for (String contactType in contacts.keys)
                      //
                      for (String url in contacts[contactType]["id"])
                        _getContactWidget(
                          urlLink: _getUrlDomain(contactType, url),
                          contents: [contacts[contactType]["icon"], ShadowText('  $url')],
                        ),
                  ],
                ),
              ],
            ),
          ),

          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          // Back button
          CustomButton(
            msg: 'Back',
            onTap: context.pop,
            margin: EdgeInsets.symmetric(
              horizontal: responsiveUI.own(0.05),
              vertical: responsiveUI.own(0.11),
            ),
            padding: EdgeInsets.symmetric(
              vertical: responsiveUI.own(0.02),
              horizontal: responsiveUI.own(0.035),
            ),
            gradientColor: [
              kColor(context).primary.withOpacity(0.85),
              kColor(context).secondary.withOpacity(0.65),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: kColor(context).tertiary,
                  size: responsiveUI.own(0.04),
                ),
                const ShadowText('Back'),
              ],
            ),
          ),
          //
          // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          //
        ],
      ),
    );
  }
}
