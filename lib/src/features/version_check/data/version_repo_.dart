// coverage:ignore-file
import '../domain/version_check.dart';

abstract class VersionCheckRepo {
  const VersionCheckRepo();
  Future<VersionCheck> getVersionCheck();
}
