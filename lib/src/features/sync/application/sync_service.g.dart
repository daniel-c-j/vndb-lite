// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(syncService)
const syncServiceProvider = SyncServiceProvider._();

final class SyncServiceProvider
    extends $FunctionalProvider<SyncService, SyncService, SyncService>
    with $Provider<SyncService> {
  const SyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncServiceProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          remoteSyncRepoProvider,
          localVnRepoProvider,
          localSyncRepoProvider,
          localNotifServiceProvider,
          localCollectionRepoProvider,
          validateVnAndSaveToLocalProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          SyncServiceProvider.$allTransitiveDependencies0,
          SyncServiceProvider.$allTransitiveDependencies1,
          SyncServiceProvider.$allTransitiveDependencies2,
          SyncServiceProvider.$allTransitiveDependencies3,
          SyncServiceProvider.$allTransitiveDependencies4,
          SyncServiceProvider.$allTransitiveDependencies5,
          SyncServiceProvider.$allTransitiveDependencies6,
          SyncServiceProvider.$allTransitiveDependencies7,
          SyncServiceProvider.$allTransitiveDependencies8,
          SyncServiceProvider.$allTransitiveDependencies9,
          SyncServiceProvider.$allTransitiveDependencies10,
        },
      );

  static const $allTransitiveDependencies0 = remoteSyncRepoProvider;
  static const $allTransitiveDependencies1 =
      RemoteSyncRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RemoteSyncRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      RemoteSyncRepoProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      RemoteSyncRepoProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      RemoteSyncRepoProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies6 = localVnRepoProvider;
  static const $allTransitiveDependencies7 = localSyncRepoProvider;
  static const $allTransitiveDependencies8 = localNotifServiceProvider;
  static const $allTransitiveDependencies9 = validateVnAndSaveToLocalProvider;
  static const $allTransitiveDependencies10 =
      ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$syncServiceHash();

  @$internal
  @override
  $ProviderElement<SyncService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncService create(Ref ref) {
    return syncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncService>(value),
    );
  }
}

String _$syncServiceHash() => r'f9e140ad82eef33a2021f036f017a9c7375e797b';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
