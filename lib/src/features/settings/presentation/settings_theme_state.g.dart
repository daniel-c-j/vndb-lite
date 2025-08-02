// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_theme_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SettingsThemeState)
const settingsThemeStateProvider = SettingsThemeStateProvider._();

final class SettingsThemeStateProvider
    extends $NotifierProvider<SettingsThemeState, SettingsThemeConf> {
  const SettingsThemeStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsThemeStateProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          SettingsThemeStateProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$settingsThemeStateHash();

  @$internal
  @override
  SettingsThemeState create() => SettingsThemeState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsThemeConf value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsThemeConf>(value),
    );
  }
}

String _$settingsThemeStateHash() =>
    r'6fefef459fd14cb06b1460dbbcc9ec7a32a115af';

abstract class _$SettingsThemeState extends $Notifier<SettingsThemeConf> {
  SettingsThemeConf build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SettingsThemeConf, SettingsThemeConf>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SettingsThemeConf, SettingsThemeConf>,
              SettingsThemeConf,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
