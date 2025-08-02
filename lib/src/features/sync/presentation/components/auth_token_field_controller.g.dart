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

@ProviderFor(AuthTokenFieldController)
const authTokenFieldControllerProvider = AuthTokenFieldControllerProvider._();

final class AuthTokenFieldControllerProvider
    extends $NotifierProvider<AuthTokenFieldController, String> {
  const AuthTokenFieldControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authTokenFieldControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authTokenFieldControllerHash();

  @$internal
  @override
  AuthTokenFieldController create() => AuthTokenFieldController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$authTokenFieldControllerHash() =>
    r'b37e1cd4844595215da1c5abb7e15755f44f7801';

abstract class _$AuthTokenFieldController extends $Notifier<String> {
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

@ProviderFor(AuthTokenFieldServerErrorController)
const authTokenFieldServerErrorControllerProvider =
    AuthTokenFieldServerErrorControllerProvider._();

final class AuthTokenFieldServerErrorControllerProvider
    extends $NotifierProvider<AuthTokenFieldServerErrorController, String> {
  const AuthTokenFieldServerErrorControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authTokenFieldServerErrorControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$authTokenFieldServerErrorControllerHash();

  @$internal
  @override
  AuthTokenFieldServerErrorController create() =>
      AuthTokenFieldServerErrorController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$authTokenFieldServerErrorControllerHash() =>
    r'693de185380b77464f342f6fbaa7cf87d60deea3';

abstract class _$AuthTokenFieldServerErrorController extends $Notifier<String> {
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
