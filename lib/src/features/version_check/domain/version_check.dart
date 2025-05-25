// coverage:ignore-file
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:version/version.dart';

/// Model class for version check feature.
class VersionCheck {
  final bool canUpdate;
  final bool mustUpdate;
  final Version latestVersion;
  final Version requiredToUpdateVer;

  const VersionCheck({
    required this.canUpdate,
    required this.mustUpdate,
    required this.latestVersion,
    required this.requiredToUpdateVer,
  });

  VersionCheck copyWith({
    bool? canUpdate,
    bool? mustUpdate,
    Version? latestVersion,
    Version? requiredToUpdateVer,
  }) {
    return VersionCheck(
      canUpdate: canUpdate ?? this.canUpdate,
      mustUpdate: mustUpdate ?? this.mustUpdate,
      latestVersion: latestVersion ?? this.latestVersion,
      requiredToUpdateVer: requiredToUpdateVer ?? this.requiredToUpdateVer,
    );
  }

  @override
  String toString() {
    return 'VersionCheck(canUpdate: $canUpdate, mustUpdate: $mustUpdate, latestVersion: $latestVersion, requiredToUpdateVer: $requiredToUpdateVer)';
  }

  @override
  bool operator ==(covariant VersionCheck other) {
    if (identical(this, other)) return true;

    return other.canUpdate == canUpdate &&
        other.mustUpdate == mustUpdate &&
        other.latestVersion == latestVersion &&
        other.requiredToUpdateVer == requiredToUpdateVer;
  }

  @override
  int get hashCode {
    return canUpdate.hashCode ^ mustUpdate.hashCode ^ latestVersion.hashCode ^ requiredToUpdateVer.hashCode;
  }
}
