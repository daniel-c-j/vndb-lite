// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footer_button_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VnButtonState)
const vnButtonStateProvider = VnButtonStateProvider._();

final class VnButtonStateProvider
    extends $NotifierProvider<VnButtonState, ButtonState> {
  const VnButtonStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vnButtonStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vnButtonStateHash();

  @$internal
  @override
  VnButtonState create() => VnButtonState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ButtonState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ButtonState>(value),
    );
  }
}

String _$vnButtonStateHash() => r'be63726dadc849161c96fff8aebed9a9c6c83d43';

abstract class _$VnButtonState extends $Notifier<ButtonState> {
  ButtonState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ButtonState, ButtonState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ButtonState, ButtonState>,
              ButtonState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
