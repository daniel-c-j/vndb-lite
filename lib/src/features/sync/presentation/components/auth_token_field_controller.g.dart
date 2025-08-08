// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_field_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ShowAuthTokenFieldState)
const showAuthTokenFieldStateProvider = ShowAuthTokenFieldStateProvider._();

final class ShowAuthTokenFieldStateProvider
    extends $NotifierProvider<ShowAuthTokenFieldState, bool> {
  const ShowAuthTokenFieldStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'showAuthTokenFieldStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$showAuthTokenFieldStateHash();

  @$internal
  @override
  ShowAuthTokenFieldState create() => ShowAuthTokenFieldState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$showAuthTokenFieldStateHash() =>
    r'74d87914dbf4fba065525fbeedb033aba65736bd';

abstract class _$ShowAuthTokenFieldState extends $Notifier<bool> {
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

@ProviderFor(AuthTokenFieldState)
const authTokenFieldStateProvider = AuthTokenFieldStateProvider._();

final class AuthTokenFieldStateProvider
    extends $NotifierProvider<AuthTokenFieldState, String> {
  const AuthTokenFieldStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authTokenFieldStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authTokenFieldStateHash();

  @$internal
  @override
  AuthTokenFieldState create() => AuthTokenFieldState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$authTokenFieldStateHash() =>
    r'c1fe02e23e66b8f9ad5ba3d2bcea93075e46b51d';

abstract class _$AuthTokenFieldState extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(AuthTokenFieldServerErrorState)
const authTokenFieldServerErrorStateProvider =
    AuthTokenFieldServerErrorStateProvider._();

final class AuthTokenFieldServerErrorStateProvider
    extends $NotifierProvider<AuthTokenFieldServerErrorState, String> {
  const AuthTokenFieldServerErrorStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authTokenFieldServerErrorStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authTokenFieldServerErrorStateHash();

  @$internal
  @override
  AuthTokenFieldServerErrorState create() => AuthTokenFieldServerErrorState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$authTokenFieldServerErrorStateHash() =>
    r'9193915af2ac1bb9abcef45e7fc71600912c7583';

abstract class _$AuthTokenFieldServerErrorState extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
