// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_general_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SettingsGeneralState)
const settingsGeneralStateProvider = SettingsGeneralStateProvider._();

final class SettingsGeneralStateProvider
    extends $NotifierProvider<SettingsGeneralState, SettingsGeneralConf> {
  const SettingsGeneralStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsGeneralStateProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          SettingsGeneralStateProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$settingsGeneralStateHash();

  @$internal
  @override
  SettingsGeneralState create() => SettingsGeneralState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsGeneralConf value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsGeneralConf>(value),
    );
  }
}

String _$settingsGeneralStateHash() =>
    r'185cfa02b6a3a66a70c5812481295820c8b0be8c';

abstract class _$SettingsGeneralState extends $Notifier<SettingsGeneralConf> {
  SettingsGeneralConf build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SettingsGeneralConf, SettingsGeneralConf>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SettingsGeneralConf, SettingsGeneralConf>,
              SettingsGeneralConf,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
