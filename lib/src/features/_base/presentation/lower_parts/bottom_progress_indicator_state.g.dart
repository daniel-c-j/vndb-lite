// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_progress_indicator_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(BottomProgressIndicator)
const bottomProgressIndicatorProvider = BottomProgressIndicatorProvider._();

final class BottomProgressIndicatorProvider
    extends $NotifierProvider<BottomProgressIndicator, bool> {
  const BottomProgressIndicatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bottomProgressIndicatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bottomProgressIndicatorHash();

  @$internal
  @override
  BottomProgressIndicator create() => BottomProgressIndicator();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$bottomProgressIndicatorHash() =>
    r'17a9e9fd7b6042d0bc854d4114409229ac92dd15';

abstract class _$BottomProgressIndicator extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
