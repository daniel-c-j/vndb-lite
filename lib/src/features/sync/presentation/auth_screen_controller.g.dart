// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(AuthScreenController)
const authScreenControllerProvider = AuthScreenControllerProvider._();

final class AuthScreenControllerProvider
    extends $NotifierProvider<AuthScreenController, UserIdentity?> {
  const AuthScreenControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authScreenControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          localSyncRepoProvider,
          remoteSyncRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          AuthScreenControllerProvider.$allTransitiveDependencies0,
          AuthScreenControllerProvider.$allTransitiveDependencies1,
          AuthScreenControllerProvider.$allTransitiveDependencies2,
          AuthScreenControllerProvider.$allTransitiveDependencies3,
          AuthScreenControllerProvider.$allTransitiveDependencies4,
          AuthScreenControllerProvider.$allTransitiveDependencies5,
          AuthScreenControllerProvider.$allTransitiveDependencies6,
        },
      );

  static const $allTransitiveDependencies0 = localSyncRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalSyncRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = remoteSyncRepoProvider;
  static const $allTransitiveDependencies3 =
      RemoteSyncRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      RemoteSyncRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies5 =
      RemoteSyncRepoProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies6 =
      RemoteSyncRepoProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$authScreenControllerHash();

  @$internal
  @override
  AuthScreenController create() => AuthScreenController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserIdentity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserIdentity?>(value),
    );
  }
}

String _$authScreenControllerHash() =>
    r'3c866fffc614551e842a53b1f022ade91fb15e3b';

abstract class _$AuthScreenController extends $Notifier<UserIdentity?> {
  UserIdentity? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserIdentity?, UserIdentity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserIdentity?, UserIdentity?>,
              UserIdentity?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
