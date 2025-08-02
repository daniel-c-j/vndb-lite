// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_vn_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(remoteVnRepo)
const remoteVnRepoProvider = RemoteVnRepoProvider._();

final class RemoteVnRepoProvider
    extends $FunctionalProvider<RemoteVnRepo, RemoteVnRepo, RemoteVnRepo>
    with $Provider<RemoteVnRepo> {
  const RemoteVnRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteVnRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[apiServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          RemoteVnRepoProvider.$allTransitiveDependencies0,
          RemoteVnRepoProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = apiServiceProvider;
  static const $allTransitiveDependencies1 =
      ApiServiceProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$remoteVnRepoHash();

  @$internal
  @override
  $ProviderElement<RemoteVnRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RemoteVnRepo create(Ref ref) {
    return remoteVnRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteVnRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteVnRepo>(value),
    );
  }
}

String _$remoteVnRepoHash() => r'88fb46bfcd73c96d835a830d7536c2ebf3c096d7';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
