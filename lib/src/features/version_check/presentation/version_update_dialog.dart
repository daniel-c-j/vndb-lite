import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vndb_lite/src/common_widgets/custom_dialog.dart';
import 'package:vndb_lite/src/common_widgets/custom_dialog_button.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';

import '../../../constants/_constants.dart';
import '../../../util/context_shortcut.dart';
import '../domain/version_check.dart';

/// Content of the version update dialog.
class VersionUpdateDialog extends StatelessWidget {
  const VersionUpdateDialog(this.versionCheck, {super.key});

  final VersionCheck versionCheck;

  static Future<void> show(BuildContext context, VersionCheck ver) async {
    return await showDialog(
      context: context,
      useSafeArea: true,
      builder:
          (context) => CustomDialog(useContentPadding: true, content: VersionUpdateDialog(ver)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShadowText(
          "New update v${versionCheck.latestVersion} ${versionCheck.mustUpdate ? "is required" : ""}",
          align: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: responsiveUI.catgTitle,
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        SizedBox(height: responsiveUI.own(0.01)),
        ShadowText("There is a new improved version of this app.", align: TextAlign.center),
        SizedBox(height: responsiveUI.own(0.01)),
        // TODO custom remote text in here.
        ShadowText(
          "Make sure you synchronize all of your current collection to the cloud before updating the app "
          "if you still want to keep your data. Thank you for your attention! :D",
          align: TextAlign.center,
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
        SizedBox(height: responsiveUI.own(0.02)),
        // TODO custom remote text in here.
        CustomDialogButton(
          text: "Take me to the download page",
          textColor: kColor(context).primary,
          textShadow: const [Shadow(color: Color.fromARGB(120, 0, 0, 0), blurRadius: 1)],
          color: kColor(context).tertiary,
          leading: Padding(
            padding: EdgeInsets.only(right: responsiveUI.own(0.01)),
            child: Icon(
              Icons.system_update_alt,
              color: kColor(context).primary,
              size: responsiveUI.own(0.05),
            ),
          ),
          onPressed: () async {
            final url = Uri.parse(NetConsts.URL_UPDATE_VERSION);
            await launchUrl(url);
          },
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
    );
  }
}
