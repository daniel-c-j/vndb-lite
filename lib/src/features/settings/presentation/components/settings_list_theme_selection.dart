// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/app.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_theme_state.dart';
import 'package:vndb_lite/src/features/theme/data/theme_data.dart';
import 'package:vndb_lite/src/features/theme/theme_data_provider.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class ListThemeSelection extends ConsumerWidget {
  const ListThemeSelection({super.key, required this.refresh});

  final Future<void> Function() refresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: responsiveUI.own(0.05),
            left: responsiveUI.own(0.05),
            bottom: responsiveUI.own(0.03),
          ),
          child: ShadowText(
            "You would have to restart the app for the configured change to take effect.",
          ),
        ),
        const Divider(indent: 0, height: 0, thickness: 0, endIndent: 0),
        SizedBox(
          height:
              (MediaQuery.of(context).orientation == Orientation.portrait)
                  ? MediaQuery.sizeOf(context).height * 0.5
                  : MediaQuery.sizeOf(context).height * 0.4,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (ThemeCode themeCode in ThemeCode.values)
                  GestureDetector(
                    onTap: () async {
                      ref.read(appThemeStateProvider.notifier).appTheme = themeCode;

                      await refresh();
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      dense: true,
                      title: Text(
                        themeCode.themeName,
                        style: TextStyle(
                          color: themeCode.secondary,
                          backgroundColor: themeCode.primary,
                          fontSize: responsiveUI.normalSize,
                        ),
                      ),
                      leading: Radio(
                        value: themeCode,
                        groupValue: ref.read(appThemeStateProvider),
                        onChanged: (val) async {
                          ref.read(appThemeStateProvider.notifier).appTheme = themeCode;

                          await refresh();
                          Navigator.of(context).pop();
                        },
                        fillColor: WidgetStatePropertyAll(kColor(context).tertiary),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const Divider(indent: 0, height: 0, thickness: 0, endIndent: 0),
      ],
    );
  }
}
