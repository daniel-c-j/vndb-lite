// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_home_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remoteHomeRepoHash() => r'1bbaadf8de43e8e88558c8287f673ed0e4ca5c06';

/// See also [remoteHomeRepo].
@ProviderFor(remoteHomeRepo)
final remoteHomeRepoProvider = AutoDisposeProvider<RemoteHomeRepoImpl>.internal(
  remoteHomeRepo,
  name: r'remoteHomeRepoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remoteHomeRepoHash,
  dependencies: <ProviderOrFamily>[
    apiServiceProvider,
    sharedPrefProvider,
    localVnRepoProvider,
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    apiServiceProvider,
    ...?apiServiceProvider.allTransitiveDependencies,
    sharedPrefProvider,
    ...?sharedPrefProvider.allTransitiveDependencies,
    localVnRepoProvider,
    ...?localVnRepoProvider.allTransitiveDependencies,
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteHomeRepoRef = AutoDisposeProviderRef<RemoteHomeRepoImpl>;
String _$fetchPreviewHash() => r'd80837b7e84f41b7c5e2b2a74a96e4ce8fa32b9e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchPreview].
@ProviderFor(fetchPreview)
const fetchPreviewProvider = FetchPreviewFamily();

/// See also [fetchPreview].
class FetchPreviewFamily extends Family<AsyncValue<Response>> {
  /// See also [fetchPreview].
  const FetchPreviewFamily();

  /// See also [fetchPreview].
  FetchPreviewProvider call(
    HomeSectionsCode sectionData,
    int maxItem, {
    CancelToken? cancelToken,
  }) {
    return FetchPreviewProvider(sectionData, maxItem, cancelToken: cancelToken);
  }

  @override
  FetchPreviewProvider getProviderOverride(
    covariant FetchPreviewProvider provider,
  ) {
    return call(
      provider.sectionData,
      provider.maxItem,
      cancelToken: provider.cancelToken,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    remoteHomeRepoProvider,
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
        remoteHomeRepoProvider,
        ...?remoteHomeRepoProvider.allTransitiveDependencies,
      };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchPreviewProvider';
}

/// See also [fetchPreview].
class FetchPreviewProvider extends AutoDisposeFutureProvider<Response> {
  /// See also [fetchPreview].
  FetchPreviewProvider(
    HomeSectionsCode sectionData,
    int maxItem, {
    CancelToken? cancelToken,
  }) : this._internal(
         (ref) => fetchPreview(
           ref as FetchPreviewRef,
           sectionData,
           maxItem,
           cancelToken: cancelToken,
         ),
         from: fetchPreviewProvider,
         name: r'fetchPreviewProvider',
         debugGetCreateSourceHash:
             const bool.fromEnvironment('dart.vm.product')
                 ? null
                 : _$fetchPreviewHash,
         dependencies: FetchPreviewFamily._dependencies,
         allTransitiveDependencies:
             FetchPreviewFamily._allTransitiveDependencies,
         sectionData: sectionData,
         maxItem: maxItem,
         cancelToken: cancelToken,
       );

  FetchPreviewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sectionData,
    required this.maxItem,
    required this.cancelToken,
  }) : super.internal();

  final HomeSectionsCode sectionData;
  final int maxItem;
  final CancelToken? cancelToken;

  @override
  Override overrideWith(
    FutureOr<Response> Function(FetchPreviewRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchPreviewProvider._internal(
        (ref) => create(ref as FetchPreviewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sectionData: sectionData,
        maxItem: maxItem,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Response> createElement() {
    return _FetchPreviewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPreviewProvider &&
        other.sectionData == sectionData &&
        other.maxItem == maxItem &&
        other.cancelToken == cancelToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectionData.hashCode);
    hash = _SystemHash.combine(hash, maxItem.hashCode);
    hash = _SystemHash.combine(hash, cancelToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchPreviewRef on AutoDisposeFutureProviderRef<Response> {
  /// The parameter `sectionData` of this provider.
  HomeSectionsCode get sectionData;

  /// The parameter `maxItem` of this provider.
  int get maxItem;

  /// The parameter `cancelToken` of this provider.
  CancelToken? get cancelToken;
}

class _FetchPreviewProviderElement
    extends AutoDisposeFutureProviderElement<Response>
    with FetchPreviewRef {
  _FetchPreviewProviderElement(super.provider);

  @override
  HomeSectionsCode get sectionData =>
      (origin as FetchPreviewProvider).sectionData;
  @override
  int get maxItem => (origin as FetchPreviewProvider).maxItem;
  @override
  CancelToken? get cancelToken => (origin as FetchPreviewProvider).cancelToken;
}

String _$cachePreviewHash() => r'7042d250e1173c0cce6aa7c0e13274633376db60';

/// See also [cachePreview].
@ProviderFor(cachePreview)
const cachePreviewProvider = CachePreviewFamily();

/// See also [cachePreview].
class CachePreviewFamily extends Family<AsyncValue<void>> {
  /// See also [cachePreview].
  const CachePreviewFamily();

  /// See also [cachePreview].
  CachePreviewProvider call(
    List<VnDataPhase01> vnData, {
    required String cacheKey,
  }) {
    return CachePreviewProvider(vnData, cacheKey: cacheKey);
  }

  @override
  CachePreviewProvider getProviderOverride(
    covariant CachePreviewProvider provider,
  ) {
    return call(provider.vnData, cacheKey: provider.cacheKey);
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    remoteHomeRepoProvider,
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
        remoteHomeRepoProvider,
        ...?remoteHomeRepoProvider.allTransitiveDependencies,
      };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cachePreviewProvider';
}

/// See also [cachePreview].
class CachePreviewProvider extends AutoDisposeFutureProvider<void> {
  /// See also [cachePreview].
  CachePreviewProvider(List<VnDataPhase01> vnData, {required String cacheKey})
    : this._internal(
        (ref) =>
            cachePreview(ref as CachePreviewRef, vnData, cacheKey: cacheKey),
        from: cachePreviewProvider,
        name: r'cachePreviewProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$cachePreviewHash,
        dependencies: CachePreviewFamily._dependencies,
        allTransitiveDependencies:
            CachePreviewFamily._allTransitiveDependencies,
        vnData: vnData,
        cacheKey: cacheKey,
      );

  CachePreviewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.vnData,
    required this.cacheKey,
  }) : super.internal();

  final List<VnDataPhase01> vnData;
  final String cacheKey;

  @override
  Override overrideWith(
    FutureOr<void> Function(CachePreviewRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CachePreviewProvider._internal(
        (ref) => create(ref as CachePreviewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        vnData: vnData,
        cacheKey: cacheKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _CachePreviewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CachePreviewProvider &&
        other.vnData == vnData &&
        other.cacheKey == cacheKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, vnData.hashCode);
    hash = _SystemHash.combine(hash, cacheKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CachePreviewRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `vnData` of this provider.
  List<VnDataPhase01> get vnData;

  /// The parameter `cacheKey` of this provider.
  String get cacheKey;
}

class _CachePreviewProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with CachePreviewRef {
  _CachePreviewProviderElement(super.provider);

  @override
  List<VnDataPhase01> get vnData => (origin as CachePreviewProvider).vnData;
  @override
  String get cacheKey => (origin as CachePreviewProvider).cacheKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
