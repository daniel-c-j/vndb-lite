// coverage:ignore-file
// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:package_info_plus/package_info_plus.dart';

/// Basic app identity informations.
final class AppInfo {
  static const String unknown = "UNKNOWN";

  // ! These two are crucial and should not depend on the packageInfo or any changing operations.
  static const String TITLE = "VNDB Lite";
  static const String DESCRIPTION =
      "A lite, free, and open-source mobile version of your favorite website, vndb.org.";

  // ! Must be initialized first before being used.
  static late final String CURRENT_VERSION;
  static late final String PACKAGE_NAME;
  static late final String BUILD_NUMBER;
  static late final String BUILD_SIGNATURE;

  /// Getting information of the app.
  static Future<void> init(PackageInfoWrapper info) async {
    try {
      final PackageInfo packageInfo = await info.fromPlatform();

      CURRENT_VERSION = packageInfo.version;
      PACKAGE_NAME = packageInfo.packageName;
      BUILD_NUMBER = packageInfo.buildNumber;
      BUILD_SIGNATURE = packageInfo.buildSignature;
    } catch (e) {
      CURRENT_VERSION = unknown;
      PACKAGE_NAME = unknown;
      BUILD_NUMBER = unknown;
      BUILD_SIGNATURE = unknown;
    }
  }
}

/// Helper class to easily mock the [PackageInfo], since `PackageInfo.fromPlatform()` is  a static method,
/// and is hard to test.
class PackageInfoWrapper {
  const PackageInfoWrapper();
  Future<PackageInfo> fromPlatform() async => await PackageInfo.fromPlatform();
}
