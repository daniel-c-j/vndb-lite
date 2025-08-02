// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_home_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localHomeRepo)
const localHomeRepoProvider = LocalHomeRepoProvider._();

final class LocalHomeRepoProvider
    extends
        $FunctionalProvider<
          LocalHomeRepoImpl,
          LocalHomeRepoImpl,
          LocalHomeRepoImpl
        >
    with $Provider<LocalHomeRepoImpl> {
  const LocalHomeRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localHomeRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          LocalHomeRepoProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$localHomeRepoHash();

  @$internal
  @override
  $ProviderElement<LocalHomeRepoImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalHomeRepoImpl create(Ref ref) {
    return localHomeRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalHomeRepoImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalHomeRepoImpl>(value),
    );
  }
}

String _$localHomeRepoHash() => r'5c29abceceb5a17ad9fdfa698da41266ece1569e';

@ProviderFor(fetchCachedPreview)
const fetchCachedPreviewProvider = FetchCachedPreviewFamily._();

final class FetchCachedPreviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  const FetchCachedPreviewProvider._({
    required FetchCachedPreviewFamily super.from,
    required (int, {String cacheKey}) super.argument,
  }) : super(
         retry: null,
         name: r'fetchCachedPreviewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = localHomeRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalHomeRepoProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$fetchCachedPreviewHash();

  @override
  String toString() {
    return r'fetchCachedPreviewProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    final argument = this.argument as (int, {String cacheKey});
    return fetchCachedPreview(ref, argument.$1, cacheKey: argument.cacheKey);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCachedPreviewProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchCachedPreviewHash() =>
    r'0d940530615fc873855eeaa3ed42187239633a10';

final class FetchCachedPreviewFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<String>>,
          (int, {String cacheKey})
        > {
  const FetchCachedPreviewFamily._()
    : super(
        retry: null,
        name: r'fetchCachedPreviewProvider',
        dependencies: const <ProviderOrFamily>[localHomeRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          FetchCachedPreviewProvider.$allTransitiveDependencies0,
          FetchCachedPreviewProvider.$allTransitiveDependencies1,
        ],
        isAutoDispose: true,
      );

  FetchCachedPreviewProvider call(
    int maxPreviewItem, {
    required String cacheKey,
  }) => FetchCachedPreviewProvider._(
    argument: (maxPreviewItem, cacheKey: cacheKey),
    from: this,
  );

  @override
  String toString() => r'fetchCachedPreviewProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
