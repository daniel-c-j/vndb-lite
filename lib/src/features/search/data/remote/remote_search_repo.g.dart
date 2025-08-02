// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_search_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(remoteSearchRepo)
const remoteSearchRepoProvider = RemoteSearchRepoProvider._();

final class RemoteSearchRepoProvider
    extends
        $FunctionalProvider<
          RemoteSearchRepoImpl,
          RemoteSearchRepoImpl,
          RemoteSearchRepoImpl
        >
    with $Provider<RemoteSearchRepoImpl> {
  const RemoteSearchRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteSearchRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[apiServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          RemoteSearchRepoProvider.$allTransitiveDependencies0,
          RemoteSearchRepoProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = apiServiceProvider;
  static const $allTransitiveDependencies1 =
      ApiServiceProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$remoteSearchRepoHash();

  @$internal
  @override
  $ProviderElement<RemoteSearchRepoImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteSearchRepoImpl create(Ref ref) {
    return remoteSearchRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteSearchRepoImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteSearchRepoImpl>(value),
    );
  }
}

String _$remoteSearchRepoHash() => r'a6cc9b5e90cb5e64fbf41285802645b300b905cc';

@ProviderFor(remoteSearchVn)
const remoteSearchVnProvider = RemoteSearchVnFamily._();

final class RemoteSearchVnProvider
    extends
        $FunctionalProvider<AsyncValue<Response>, Response, FutureOr<Response>>
    with $FutureModifier<Response>, $FutureProvider<Response> {
  const RemoteSearchVnProvider._({
    required RemoteSearchVnFamily super.from,
    required (GenericPost, {CancelToken? cancelToken}) super.argument,
  }) : super(
         retry: null,
         name: r'remoteSearchVnProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = remoteSearchRepoProvider;
  static const $allTransitiveDependencies1 =
      RemoteSearchRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RemoteSearchRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$remoteSearchVnHash();

  @override
  String toString() {
    return r'remoteSearchVnProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Response> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Response> create(Ref ref) {
    final argument = this.argument as (GenericPost, {CancelToken? cancelToken});
    return remoteSearchVn(ref, argument.$1, cancelToken: argument.cancelToken);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoteSearchVnProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remoteSearchVnHash() => r'0a775e09ceed3cdbd2f2028a037017cc24f4d833';

final class RemoteSearchVnFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Response>,
          (GenericPost, {CancelToken? cancelToken})
        > {
  const RemoteSearchVnFamily._()
    : super(
        retry: null,
        name: r'remoteSearchVnProvider',
        dependencies: const <ProviderOrFamily>[remoteSearchRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          RemoteSearchVnProvider.$allTransitiveDependencies0,
          RemoteSearchVnProvider.$allTransitiveDependencies1,
          RemoteSearchVnProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: true,
      );

  RemoteSearchVnProvider call(
    GenericPost requestData, {
    CancelToken? cancelToken,
  }) => RemoteSearchVnProvider._(
    argument: (requestData, cancelToken: cancelToken),
    from: this,
  );

  @override
  String toString() => r'remoteSearchVnProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
