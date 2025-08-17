import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/features/_base/presentation/upper_parts/tabs_sliver_appbar.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/others/data/others_option_data.dart';
import 'package:vndb_lite/src/features/others/domain/others_option.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

class OthersScreen extends ConsumerWidget {
  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (_, __) => const [TabAppBar(route: AppRoute.others)],
      body: Column(
        children: [
          for (OthersScreenOption otherOption in OTHERS_SCREEN_OPTIONS.values)
            //
            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            //
            ListTile(
              onTap: () {
                if (otherOption.routeName == OthersOptionCode.bug.name) {
                  launchUrlString("https://github.com/Daniel-C-J/vndb-lite/issues/new");
                  return;
                }

                context.pushNamed(otherOption.routeName);
              },
              leading: Icon(
                otherOption.leading,
                color: kColor(context).secondary,
                size: responsiveUI.own(0.06),
                shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
              ),
              title: ShadowText(otherOption.title),
              subtitle:
                  (otherOption.subtitle != null)
                      ? ShadowText(
                        otherOption.subtitle!,
                        fontSize: responsiveUI.own(0.03),
                        color: kColor(context).tertiary.withAlpha(180),
                      )
                      : null,
              tileColor: kColor(context).primary.withAlpha(175),
              dense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: responsiveUI.own(0.045),
                vertical: responsiveUI.own(0.005),
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
