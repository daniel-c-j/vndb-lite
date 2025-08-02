// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_confirm_button_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AuthButtonState)
const authButtonStateProvider = AuthButtonStateProvider._();

final class AuthButtonStateProvider
    extends $NotifierProvider<AuthButtonState, ButtonState> {
  const AuthButtonStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authButtonStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authButtonStateHash();

  @$internal
  @override
  AuthButtonState create() => AuthButtonState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ButtonState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ButtonState>(value),
    );
  }
}

String _$authButtonStateHash() => r'1eb5d71ad5d93ef45d2365e41451df7a3e16dba7';

abstract class _$AuthButtonState extends $Notifier<ButtonState> {
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
