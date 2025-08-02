// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_data_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SettingsDataState)
const settingsDataStateProvider = SettingsDataStateProvider._();

final class SettingsDataStateProvider
    extends $NotifierProvider<SettingsDataState, SettingsDataConf> {
  const SettingsDataStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsDataStateProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          SettingsDataStateProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$settingsDataStateHash();

  @$internal
  @override
  SettingsDataState create() => SettingsDataState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsDataConf value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsDataConf>(value),
    );
  }
}

String _$settingsDataStateHash() => r'c0aeb0e78de0a9449374be033afe414e61c429ef';

abstract class _$SettingsDataState extends $Notifier<SettingsDataConf> {
  SettingsDataConf build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SettingsDataConf, SettingsDataConf>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SettingsDataConf, SettingsDataConf>,
              SettingsDataConf,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
