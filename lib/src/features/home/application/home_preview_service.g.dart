// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_preview_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homePreviewServiceHash() =>
    r'2ef4eb34c6a6e92506e9657d908518ef4ae2321e';

/// See also [homePreviewService].
@ProviderFor(homePreviewService)
final homePreviewServiceProvider =
    AutoDisposeProvider<HomePreviewService>.internal(
      homePreviewService,
      name: r'homePreviewServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$homePreviewServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomePreviewServiceRef = AutoDisposeProviderRef<HomePreviewService>;
String _$getPreviewDataHash() => r'3c4a4f5ce7900b58e8f67fd4218c9226dc399f88';

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

/// See also [getPreviewData].
@ProviderFor(getPreviewData)
const getPreviewDataProvider = GetPreviewDataFamily();

/// See also [getPreviewData].
class GetPreviewDataFamily extends Family<AsyncValue<dynamic>> {
  /// See also [getPreviewData].
  const GetPreviewDataFamily();

  /// See also [getPreviewData].
  GetPreviewDataProvider call({
    required HomeSectionsCode sectionData,
    required String cacheKey,
    required int maxItem,
    CancelToken? cancelToken,
  }) {
    return GetPreviewDataProvider(
      sectionData: sectionData,
      cacheKey: cacheKey,
      maxItem: maxItem,
      cancelToken: cancelToken,
    );
  }

  @override
  GetPreviewDataProvider getProviderOverride(
    covariant GetPreviewDataProvider provider,
  ) {
    return call(
      sectionData: provider.sectionData,
      cacheKey: provider.cacheKey,
      maxItem: provider.maxItem,
      cancelToken: provider.cancelToken,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getPreviewDataProvider';
}

/// See also [getPreviewData].
class GetPreviewDataProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [getPreviewData].
  GetPreviewDataProvider({
    required HomeSectionsCode sectionData,
    required String cacheKey,
    required int maxItem,
    CancelToken? cancelToken,
  }) : this._internal(
         (ref) => getPreviewData(
           ref as GetPreviewDataRef,
           sectionData: sectionData,
           cacheKey: cacheKey,
           maxItem: maxItem,
           cancelToken: cancelToken,
         ),
         from: getPreviewDataProvider,
         name: r'getPreviewDataProvider',
         debugGetCreateSourceHash:
             const bool.fromEnvironment('dart.vm.product')
                 ? null
                 : _$getPreviewDataHash,
         dependencies: GetPreviewDataFamily._dependencies,
         allTransitiveDependencies:
             GetPreviewDataFamily._allTransitiveDependencies,
         sectionData: sectionData,
         cacheKey: cacheKey,
         maxItem: maxItem,
         cancelToken: cancelToken,
       );

  GetPreviewDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sectionData,
    required this.cacheKey,
    required this.maxItem,
    required this.cancelToken,
  }) : super.internal();

  final HomeSectionsCode sectionData;
  final String cacheKey;
  final int maxItem;
  final CancelToken? cancelToken;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(GetPreviewDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPreviewDataProvider._internal(
        (ref) => create(ref as GetPreviewDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sectionData: sectionData,
        cacheKey: cacheKey,
        maxItem: maxItem,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _GetPreviewDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPreviewDataProvider &&
        other.sectionData == sectionData &&
        other.cacheKey == cacheKey &&
        other.maxItem == maxItem &&
        other.cancelToken == cancelToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sectionData.hashCode);
    hash = _SystemHash.combine(hash, cacheKey.hashCode);
    hash = _SystemHash.combine(hash, maxItem.hashCode);
    hash = _SystemHash.combine(hash, cancelToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetPreviewDataRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `sectionData` of this provider.
  HomeSectionsCode get sectionData;

  /// The parameter `cacheKey` of this provider.
  String get cacheKey;

  /// The parameter `maxItem` of this provider.
  int get maxItem;

  /// The parameter `cancelToken` of this provider.
  CancelToken? get cancelToken;
}

class _GetPreviewDataProviderElement
    extends AutoDisposeFutureProviderElement<dynamic>
    with GetPreviewDataRef {
  _GetPreviewDataProviderElement(super.provider);

  @override
  HomeSectionsCode get sectionData =>
      (origin as GetPreviewDataProvider).sectionData;
  @override
  String get cacheKey => (origin as GetPreviewDataProvider).cacheKey;
  @override
  int get maxItem => (origin as GetPreviewDataProvider).maxItem;
  @override
  CancelToken? get cancelToken =>
      (origin as GetPreviewDataProvider).cancelToken;
}

String _$formatPreviewDataHash() => r'c4626ace9c8d16cf853ffbfe1a6e32bc8b88234e';

/// See also [formatPreviewData].
@ProviderFor(formatPreviewData)
const formatPreviewDataProvider = FormatPreviewDataFamily();

/// See also [formatPreviewData].
class FormatPreviewDataFamily extends Family<AsyncValue<List<VnDataPhase01>>> {
  /// See also [formatPreviewData].
  const FormatPreviewDataFamily();

  /// See also [formatPreviewData].
  FormatPreviewDataProvider call(dynamic rawData, {required String cacheKey}) {
    return FormatPreviewDataProvider(rawData, cacheKey: cacheKey);
  }

  @override
  FormatPreviewDataProvider getProviderOverride(
    covariant FormatPreviewDataProvider provider,
  ) {
    return call(provider.rawData, cacheKey: provider.cacheKey);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'formatPreviewDataProvider';
}

/// See also [formatPreviewData].
class FormatPreviewDataProvider
    extends AutoDisposeFutureProvider<List<VnDataPhase01>> {
  /// See also [formatPreviewData].
  FormatPreviewDataProvider(dynamic rawData, {required String cacheKey})
    : this._internal(
        (ref) => formatPreviewData(
          ref as FormatPreviewDataRef,
          rawData,
          cacheKey: cacheKey,
        ),
        from: formatPreviewDataProvider,
        name: r'formatPreviewDataProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$formatPreviewDataHash,
        dependencies: FormatPreviewDataFamily._dependencies,
        allTransitiveDependencies:
            FormatPreviewDataFamily._allTransitiveDependencies,
        rawData: rawData,
        cacheKey: cacheKey,
      );

  FormatPreviewDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rawData,
    required this.cacheKey,
  }) : super.internal();

  final dynamic rawData;
  final String cacheKey;

  @override
  Override overrideWith(
    FutureOr<List<VnDataPhase01>> Function(FormatPreviewDataRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FormatPreviewDataProvider._internal(
        (ref) => create(ref as FormatPreviewDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        rawData: rawData,
        cacheKey: cacheKey,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<VnDataPhase01>> createElement() {
    return _FormatPreviewDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormatPreviewDataProvider &&
        other.rawData == rawData &&
        other.cacheKey == cacheKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rawData.hashCode);
    hash = _SystemHash.combine(hash, cacheKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FormatPreviewDataRef
    on AutoDisposeFutureProviderRef<List<VnDataPhase01>> {
  /// The parameter `rawData` of this provider.
  dynamic get rawData;

  /// The parameter `cacheKey` of this provider.
  String get cacheKey;
}

class _FormatPreviewDataProviderElement
    extends AutoDisposeFutureProviderElement<List<VnDataPhase01>>
    with FormatPreviewDataRef {
  _FormatPreviewDataProviderElement(super.provider);

  @override
  dynamic get rawData => (origin as FormatPreviewDataProvider).rawData;
  @override
  String get cacheKey => (origin as FormatPreviewDataProvider).cacheKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
