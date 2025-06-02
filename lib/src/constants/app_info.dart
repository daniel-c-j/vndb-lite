// coverage:ignore-file
// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Basic app identity informations.
final class AppInfo {
  static const String unknown = "UNKNOWN";

  // TODO recheck whether README, Github-Codeberg Description, and Pubspec.yaml are all matching with title and desc.
  // ! These two are crucial and should not depend on the packageInfo or any changing operations.
  static const String TITLE = "VNDB Lite";
  static const String DESCRIPTION =
      "A lite, free, and open-source mobile version of your favorite website, vndb.org.";

  // ! Must be initialized first before being used.
  static late String _CURRENT_VERSION;
  static late String _PACKAGE_NAME;
  static late String _BUILD_NUMBER;
  static late String _BUILD_SIGNATURE;

  // ? Why are these needed and why the above properties are private?
  // ? - NEEDED because of unit testing purposes.
  // ?   This class is a global data container, and should be constant or not changed during runtime.
  // ?   Because the state remains static once init method is called, the only way to simulate
  // ?   the class behaviour for testing different scenarios while in the same static data container,
  // ?   is through non-final/non-const private properties and public getters.
  // ?
  // ? - PRIVATE because they should NOT be modified unless from the init method --which will be simulated
  // ?   with cases [if success] and [if fail]-- that's why they can only be accessed through
  // ?   the getters below --which will verify the testing cases--, which cannot and should not be modified.
  // ?
  // ? A better solution is to make this class a singleton and change the static method into non-static ones.
  // ? Or just use a provider and/or make this class private.
  static String get CURRENT_VERSION => _CURRENT_VERSION;
  static String get PACKAGE_NAME => _PACKAGE_NAME;
  static String get BUILD_NUMBER => _BUILD_NUMBER;
  static String get BUILD_SIGNATURE => _BUILD_SIGNATURE;

  @visibleForTesting
  static set CURRENT_VERSION(String value) => _CURRENT_VERSION = value;
  @visibleForTesting
  static set PACKAGE_NAME(String value) => _PACKAGE_NAME = value;
  @visibleForTesting
  static set BUILD_NUMBER(String value) => _BUILD_NUMBER = value;
  @visibleForTesting
  static set BUILD_SIGNATURE(String value) => _BUILD_SIGNATURE = value;

  static Future<void> init(PackageInfoWrapper info) async {
    try {
      final PackageInfo packageInfo = await info.fromPlatform();

      // Making all of these variables accessible synchronously.
      _CURRENT_VERSION = packageInfo.version;
      _PACKAGE_NAME = packageInfo.packageName;
      _BUILD_NUMBER = packageInfo.buildNumber;
      _BUILD_SIGNATURE = packageInfo.buildSignature;
    } catch (e) {
      _CURRENT_VERSION = unknown;
      _PACKAGE_NAME = unknown;
      _BUILD_NUMBER = unknown;
      _BUILD_SIGNATURE = unknown;
    }
  }
}

/// Helper class to easily mock the [PackageInfo], since `PackageInfo.fromPlatform()` is  a static method,
/// and is hard to test.
class PackageInfoWrapper {
  const PackageInfoWrapper();
  Future<PackageInfo> fromPlatform() async => await PackageInfo.fromPlatform();
}
