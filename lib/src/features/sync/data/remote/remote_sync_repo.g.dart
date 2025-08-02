// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_sync_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(remoteSyncRepo)
const remoteSyncRepoProvider = RemoteSyncRepoProvider._();

final class RemoteSyncRepoProvider
    extends $FunctionalProvider<RemoteSyncRepo, RemoteSyncRepo, RemoteSyncRepo>
    with $Provider<RemoteSyncRepo> {
  const RemoteSyncRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteSyncRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          apiServiceProvider,
          localCollectionRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          RemoteSyncRepoProvider.$allTransitiveDependencies0,
          RemoteSyncRepoProvider.$allTransitiveDependencies1,
          RemoteSyncRepoProvider.$allTransitiveDependencies2,
          RemoteSyncRepoProvider.$allTransitiveDependencies3,
          RemoteSyncRepoProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = apiServiceProvider;
  static const $allTransitiveDependencies1 =
      ApiServiceProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = localCollectionRepoProvider;
  static const $allTransitiveDependencies3 =
      LocalCollectionRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      LocalCollectionRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$remoteSyncRepoHash();

  @$internal
  @override
  $ProviderElement<RemoteSyncRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RemoteSyncRepo create(Ref ref) {
    return remoteSyncRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteSyncRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteSyncRepo>(value),
    );
  }
}

String _$remoteSyncRepoHash() => r'3e07dbf1dcbe53a2e47638e191989ac6f819059e';

@ProviderFor(authenticate)
const authenticateProvider = AuthenticateFamily._();

final class AuthenticateProvider
    extends
        $FunctionalProvider<AsyncValue<Response>, Response, FutureOr<Response>>
    with $FutureModifier<Response>, $FutureProvider<Response> {
  const AuthenticateProvider._({
    required AuthenticateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'authenticateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = remoteSyncRepoProvider;
  static const $allTransitiveDependencies1 =
      RemoteSyncRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RemoteSyncRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      RemoteSyncRepoProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      RemoteSyncRepoProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      RemoteSyncRepoProvider.$allTransitiveDependencies4;

  @override
  String debugGetCreateSourceHash() => _$authenticateHash();

  @override
  String toString() {
    return r'authenticateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Response> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Response> create(Ref ref) {
    final argument = this.argument as String;
    return authenticate(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthenticateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$authenticateHash() => r'b1589d29665648dfd168166fddd6e2b75f505b9e';

final class AuthenticateFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Response>, String> {
  const AuthenticateFamily._()
    : super(
        retry: null,
        name: r'authenticateProvider',
        dependencies: const <ProviderOrFamily>[remoteSyncRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          AuthenticateProvider.$allTransitiveDependencies0,
          AuthenticateProvider.$allTransitiveDependencies1,
          AuthenticateProvider.$allTransitiveDependencies2,
          AuthenticateProvider.$allTransitiveDependencies3,
          AuthenticateProvider.$allTransitiveDependencies4,
          AuthenticateProvider.$allTransitiveDependencies5,
        },
        isAutoDispose: true,
      );

  AuthenticateProvider call(String token) =>
      AuthenticateProvider._(argument: token, from: this);

  @override
  String toString() => r'authenticateProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
