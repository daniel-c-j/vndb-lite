// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_sort_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(collectionSortFilterService)
const collectionSortFilterServiceProvider =
    CollectionSortFilterServiceProvider._();

final class CollectionSortFilterServiceProvider
    extends
        $FunctionalProvider<
          CollectionSortFilterService,
          CollectionSortFilterService,
          CollectionSortFilterService
        >
    with $Provider<CollectionSortFilterService> {
  const CollectionSortFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionSortFilterServiceProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[localFilterServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          CollectionSortFilterServiceProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = localFilterServiceProvider;

  @override
  String debugGetCreateSourceHash() => _$collectionSortFilterServiceHash();

  @$internal
  @override
  $ProviderElement<CollectionSortFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionSortFilterService create(Ref ref) {
    return collectionSortFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionSortFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionSortFilterService>(value),
    );
  }
}

String _$collectionSortFilterServiceHash() =>
    r'7502b05326ed376ea8f9fffe526502667822b135';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
