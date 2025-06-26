import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart' show GoTransitions;
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/features/theme/theme_data_provider.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';

import 'constants/_constants.dart';
import 'core/_core.dart';

class App extends ConsumerWidget {
  const App({super.key});

  static bool updateIsChecked = false;

  // This is useful when facing with deep nested vndetail stack.
  static String currentRootRoute = "/";

  static String get currentRoute {
    final routeName = GoRouter.maybeOf(NavigationService.currentContext)?.state.name;
    if (routeName != null) return routeName;

    // Default
    return AppRoute.home.name;
  }

  static String get currentFullRoute {
    final fullRoute = GoRouter.maybeOf(NavigationService.currentContext)?.state.matchedLocation;
    if (fullRoute != null) return fullRoute;

    // Default
    return "/";
  }

  static bool get isInMainTab =>
      isInHomeScreen || isInSearchScreen || isInCollectionScreen || isInOthersScreen;
  static bool get isInHomeScreen => currentRoute.contains(AppRoute.home.name);
  static bool get isInSearchScreen => currentRoute.contains(AppRoute.search.name);
  static bool get isInCollectionScreen => currentRoute.contains(AppRoute.collection.name);
  static bool get isInOthersScreen => currentRoute.contains(AppRoute.others.name);
  static bool get isInVnDetailScreen => currentRoute.contains(AppRoute.vnDetail.name);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final theme = ref.watch(appThemeStateProvider);

    // Force removal of splash screen after everything loads.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    // Assigning an emergency globally-shared state reader.
    ref_ = ref;

    return MaterialApp.router(
      title: AppInfo.TITLE,
      restorationScopeId: "app",
      onGenerateTitle: (context) => AppInfo.TITLE,
      debugShowCheckedModeBanner: false,
      //
      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      //
      theme: ThemeData(
        useMaterial3: true,
        brightness: theme.brightness,
        colorScheme: ColorScheme.fromSeed(
          seedColor: theme.seedColor,
          primary: theme.primary,
          secondary: theme.secondary,
          tertiary: theme.tertiary,
          brightness: theme.brightness,
        ),
        dividerColor: theme.tertiary.withAlpha(150),
        dividerTheme: DividerThemeData(color: theme.tertiary.withAlpha(150)),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: theme.secondary),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: GoTransitions.fadeUpwards,
            TargetPlatform.iOS: GoTransitions.cupertino,
          },
        ),
        textTheme: TextTheme.primaryOf(context).apply(
          fontFamily: Default.FONT_FAMILY,
          bodyColor: theme.tertiary,
          displayColor: theme.tertiary,
        ),
      ),
      //
      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      //
      routerConfig: goRouter,
      // routeInformationParser: goRouter.routeInformationParser,
      // routeInformationProvider: goRouter.routeInformationProvider,
      //
      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      //
    );
  }
}
