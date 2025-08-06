// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AppThemeState)
const appThemeStateProvider = AppThemeStateProvider._();

final class AppThemeStateProvider
    extends $NotifierProvider<AppThemeState, ThemeCode> {
  const AppThemeStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeStateProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          AppThemeStateProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$appThemeStateHash();

  @$internal
  @override
  AppThemeState create() => AppThemeState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeCode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeCode>(value),
    );
  }
}

String _$appThemeStateHash() => r'9c2752019aa445ddc62d4ce986e6910a0629a18d';

abstract class _$AppThemeState extends $Notifier<ThemeCode> {
  ThemeCode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeCode, ThemeCode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeCode, ThemeCode>,
              ThemeCode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
