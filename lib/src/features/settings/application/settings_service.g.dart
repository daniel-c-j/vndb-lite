// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(settingsService)
const settingsServiceProvider = SettingsServiceProvider._();

final class SettingsServiceProvider
    extends
        $FunctionalProvider<SettingsService, SettingsService, SettingsService>
    with $Provider<SettingsService> {
  const SettingsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsServiceProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          localSyncRepoProvider,
          localCollectionRepoProvider,
          sharedPrefProvider,
          validateVnAndSaveToLocalProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          SettingsServiceProvider.$allTransitiveDependencies0,
          SettingsServiceProvider.$allTransitiveDependencies1,
          SettingsServiceProvider.$allTransitiveDependencies2,
          SettingsServiceProvider.$allTransitiveDependencies3,
          SettingsServiceProvider.$allTransitiveDependencies4,
          SettingsServiceProvider.$allTransitiveDependencies5,
          SettingsServiceProvider.$allTransitiveDependencies6,
          SettingsServiceProvider.$allTransitiveDependencies7,
          SettingsServiceProvider.$allTransitiveDependencies8,
        },
      );

  static const $allTransitiveDependencies0 = localSyncRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalSyncRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = localCollectionRepoProvider;
  static const $allTransitiveDependencies3 =
      LocalCollectionRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies4 = validateVnAndSaveToLocalProvider;
  static const $allTransitiveDependencies5 =
      ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies6 =
      ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies7 =
      ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies8 =
      ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$settingsServiceHash();

  @$internal
  @override
  $ProviderElement<SettingsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsService create(Ref ref) {
    return settingsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsService>(value),
    );
  }
}

String _$settingsServiceHash() => r'57cae3bcb7d1897587a3a94c28bbcf91ff638628';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
