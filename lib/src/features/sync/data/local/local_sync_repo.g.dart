// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_sync_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localSyncRepo)
const localSyncRepoProvider = LocalSyncRepoProvider._();

final class LocalSyncRepoProvider
    extends $FunctionalProvider<LocalSyncRepo, LocalSyncRepo, LocalSyncRepo>
    with $Provider<LocalSyncRepo> {
  const LocalSyncRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSyncRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          LocalSyncRepoProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$localSyncRepoHash();

  @$internal
  @override
  $ProviderElement<LocalSyncRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalSyncRepo create(Ref ref) {
    return localSyncRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalSyncRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalSyncRepo>(value),
    );
  }
}

String _$localSyncRepoHash() => r'29453a000e7245126b288388d9f4959a09675707';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
