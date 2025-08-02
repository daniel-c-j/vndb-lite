// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_home_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(remoteHomeRepo)
const remoteHomeRepoProvider = RemoteHomeRepoProvider._();

final class RemoteHomeRepoProvider
    extends
        $FunctionalProvider<
          RemoteHomeRepoImpl,
          RemoteHomeRepoImpl,
          RemoteHomeRepoImpl
        >
    with $Provider<RemoteHomeRepoImpl> {
  const RemoteHomeRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteHomeRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          apiServiceProvider,
          sharedPrefProvider,
          localVnRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          RemoteHomeRepoProvider.$allTransitiveDependencies0,
          RemoteHomeRepoProvider.$allTransitiveDependencies1,
          RemoteHomeRepoProvider.$allTransitiveDependencies2,
          RemoteHomeRepoProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 = apiServiceProvider;
  static const $allTransitiveDependencies1 =
      ApiServiceProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = sharedPrefProvider;
  static const $allTransitiveDependencies3 = localVnRepoProvider;

  @override
  String debugGetCreateSourceHash() => _$remoteHomeRepoHash();

  @$internal
  @override
  $ProviderElement<RemoteHomeRepoImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteHomeRepoImpl create(Ref ref) {
    return remoteHomeRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteHomeRepoImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteHomeRepoImpl>(value),
    );
  }
}

String _$remoteHomeRepoHash() => r'1bbaadf8de43e8e88558c8287f673ed0e4ca5c06';

@ProviderFor(fetchPreview)
const fetchPreviewProvider = FetchPreviewFamily._();

final class FetchPreviewProvider
    extends
        $FunctionalProvider<AsyncValue<Response>, Response, FutureOr<Response>>
    with $FutureModifier<Response>, $FutureProvider<Response> {
  const FetchPreviewProvider._({
    required FetchPreviewFamily super.from,
    required (HomeSectionsCode, int, {CancelToken? cancelToken}) super.argument,
  }) : super(
         retry: null,
         name: r'fetchPreviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = remoteHomeRepoProvider;
  static const $allTransitiveDependencies1 =
      RemoteHomeRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RemoteHomeRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      RemoteHomeRepoProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      RemoteHomeRepoProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$fetchPreviewHash();

  @override
  String toString() {
    return r'fetchPreviewProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Response> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Response> create(Ref ref) {
    final argument =
        this.argument as (HomeSectionsCode, int, {CancelToken? cancelToken});
    return fetchPreview(
      ref,
      argument.$1,
      argument.$2,
      cancelToken: argument.cancelToken,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPreviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchPreviewHash() => r'd80837b7e84f41b7c5e2b2a74a96e4ce8fa32b9e';

final class FetchPreviewFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Response>,
          (HomeSectionsCode, int, {CancelToken? cancelToken})
        > {
  const FetchPreviewFamily._()
    : super(
        retry: null,
        name: r'fetchPreviewProvider',
        dependencies: const <ProviderOrFamily>[remoteHomeRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          FetchPreviewProvider.$allTransitiveDependencies0,
          FetchPreviewProvider.$allTransitiveDependencies1,
          FetchPreviewProvider.$allTransitiveDependencies2,
          FetchPreviewProvider.$allTransitiveDependencies3,
          FetchPreviewProvider.$allTransitiveDependencies4,
        },
        isAutoDispose: true,
      );

  FetchPreviewProvider call(
    HomeSectionsCode sectionData,
    int maxItem, {
    CancelToken? cancelToken,
  }) => FetchPreviewProvider._(
    argument: (sectionData, maxItem, cancelToken: cancelToken),
    from: this,
  );

  @override
  String toString() => r'fetchPreviewProvider';
}

@ProviderFor(cachePreview)
const cachePreviewProvider = CachePreviewFamily._();

final class CachePreviewProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const CachePreviewProvider._({
    required CachePreviewFamily super.from,
    required (List<VnDataPhase01>, {String cacheKey}) super.argument,
  }) : super(
         retry: null,
         name: r'cachePreviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = remoteHomeRepoProvider;
  static const $allTransitiveDependencies1 =
      RemoteHomeRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RemoteHomeRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      RemoteHomeRepoProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      RemoteHomeRepoProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$cachePreviewHash();

  @override
  String toString() {
    return r'cachePreviewProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as (List<VnDataPhase01>, {String cacheKey});
    return cachePreview(ref, argument.$1, cacheKey: argument.cacheKey);
  }

  @override
  bool operator ==(Object other) {
    return other is CachePreviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cachePreviewHash() => r'7042d250e1173c0cce6aa7c0e13274633376db60';

final class CachePreviewFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          (List<VnDataPhase01>, {String cacheKey})
        > {
  const CachePreviewFamily._()
    : super(
        retry: null,
        name: r'cachePreviewProvider',
        dependencies: const <ProviderOrFamily>[remoteHomeRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          CachePreviewProvider.$allTransitiveDependencies0,
          CachePreviewProvider.$allTransitiveDependencies1,
          CachePreviewProvider.$allTransitiveDependencies2,
          CachePreviewProvider.$allTransitiveDependencies3,
          CachePreviewProvider.$allTransitiveDependencies4,
        },
        isAutoDispose: true,
      );

  CachePreviewProvider call(
    List<VnDataPhase01> vnData, {
    required String cacheKey,
  }) => CachePreviewProvider._(
    argument: (vnData, cacheKey: cacheKey),
    from: this,
  );

  @override
  String toString() => r'cachePreviewProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
