import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/_base/data/base_menu_sections.dart';
import 'package:vndb_lite/src/features/sync/presentation/auth_screen_controller.dart';

import '../../../../util/context_shortcut.dart';

/// Cannot be const yet due to architecture compliance.
class AppBarTitle extends ConsumerWidget {
  const AppBarTitle({super.key, required this.route});

  final AppRoute route;

  String get _activePageTitle {
    if (BASE_TAB_MENU_SECTIONS[route.name] == null) return '';
    return BASE_TAB_MENU_SECTIONS[route.name]!.title;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uId = ref.watch(authScreenControllerProvider);
    final userDidAuth = uId != null;

    return Stack(
      children: [
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // TabAppBar title
        Padding(
          padding:
              (userDidAuth && (route == AppRoute.collection))
                  ? EdgeInsets.only(top: responsiveUI.own(0.03))
                  : const EdgeInsets.only(top: 0),
          child: ShadowText(
            _activePageTitle,
            color: kColor(context).tertiary,
            fontSize:
                (userDidAuth && (route == AppRoute.collection))
                    ? responsiveUI.own(0.050)
                    : responsiveUI.own(0.0525),
          ),
        ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        // Show username when user authenticated
        if (userDidAuth && (route == AppRoute.collection))
          Wrap(
            children: [
              ShadowText(
                uId.username,
                fontWeight: FontWeight.bold,
                fontSize: responsiveUI.own(0.034),
                color: kColor(context).secondary,
              ),
              ShadowText("'s", fontSize: responsiveUI.own(0.034)),
            ],
          ),
        //
        // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        //
      ],
    );
  }
}
