// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_version_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(versionCheckRepo)
const versionCheckRepoProvider = VersionCheckRepoProvider._();

final class VersionCheckRepoProvider
    extends
        $FunctionalProvider<
          VersionCheckRepo,
          VersionCheckRepo,
          VersionCheckRepo
        >
    with $Provider<VersionCheckRepo> {
  const VersionCheckRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'versionCheckRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[apiServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          VersionCheckRepoProvider.$allTransitiveDependencies0,
          VersionCheckRepoProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = apiServiceProvider;
  static const $allTransitiveDependencies1 =
      ApiServiceProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$versionCheckRepoHash();

  @$internal
  @override
  $ProviderElement<VersionCheckRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VersionCheckRepo create(Ref ref) {
    return versionCheckRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VersionCheckRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VersionCheckRepo>(value),
    );
  }
}

String _$versionCheckRepoHash() => r'1fa89605dd59fb39a6427bf53d3390c118b8abb9';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
