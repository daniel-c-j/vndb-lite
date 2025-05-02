// coverage:ignore-file

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../_core.dart';
import '../exceptions/_exceptions.dart';

/// Extension methods specific for the "fakes/simulation" in project configuration
extension AppStartupContainer on AppStartup {
  /// Creates the top-level [ProviderContainer] by overriding necessary providers.
  /// This is useful for testing purposes and for running the app with a
  /// "fake/simulation" backend.
  ///
  /// Note: all repositories needed by the app can be accessed via providers.
  /// Some of these providers throw an [UnimplementedError] by default.
  ///
  /// Example:
  /// ```dart
  /// @Riverpod(keepAlive: true)
  /// MyRepo myRepo(Ref ref) {
  ///   throw UnimplementedError();
  /// }
  /// ```
  ///
  /// As a result, this method does two things:
  /// - create and configure the repositories as desired
  /// - override the default implementations with a list of "overrides"
  Future<ProviderContainer> initializeProviderContainer() async {
    // * Cores
    final sharedPref = await SharedPreferences.getInstance();
    // * Repositories
    // final repo = SomeFakeRepo();
    // * Services
    // final service = SomeFakeService();

    return ProviderContainer(
      overrides: [
        // * Cores
        sharedPrefProvider.overrideWithValue(sharedPref),
        // * Repositories
        // repoProvider.overrideWithValue(repo),
        // * Services
        // myServiceProvider.overrideWithValue(service),
      ],
      observers: const [AsyncErrorLogger()],
    );
  }
}
