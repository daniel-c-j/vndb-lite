import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart' show GoTransitions;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:vndb_lite/src/constants/app_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vndb_lite/src/core/_core.dart';
import 'package:vndb_lite/src/routing/app_router.dart';
import 'package:vndb_lite/src/util/alt_provider_reader.dart';

import 'features/theme/theme_data_provider.dart';

// TODO experiment with splash screen custom made

class App extends ConsumerWidget {
  const App({super.key});

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
    final themeCode = ref.watch(appThemeStateProvider);

    // Force removal of splash screen after everything loads.
    FlutterNativeSplash.remove();

    // Assigning an emergency global state reader.
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
        brightness: themeCode.brightness,
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeCode.seedColor,
          primary: themeCode.primary,
          secondary: themeCode.secondary,
          tertiary: themeCode.tertiary,
          brightness: themeCode.brightness,
        ),
        dividerColor: themeCode.tertiary.withAlpha(150),
        dividerTheme: DividerThemeData(color: themeCode.tertiary.withAlpha(150)),
        progressIndicatorTheme: ProgressIndicatorThemeData(color: themeCode.secondary),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: GoTransitions.fadeUpwards,
            TargetPlatform.iOS: GoTransitions.cupertino,
            TargetPlatform.macOS: GoTransitions.cupertino,
          },
        ),
        textTheme: GoogleFonts.rubikTextTheme().apply(
          bodyColor: themeCode.tertiary,
          displayColor: themeCode.tertiary,
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
