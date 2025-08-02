// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_sort_filter_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localSortFilterRepo)
const localSortFilterRepoProvider = LocalSortFilterRepoProvider._();

final class LocalSortFilterRepoProvider
    extends
        $FunctionalProvider<
          LocalSortFilterRepo,
          LocalSortFilterRepo,
          LocalSortFilterRepo
        >
    with $Provider<LocalSortFilterRepo> {
  const LocalSortFilterRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSortFilterRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          LocalSortFilterRepoProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$localSortFilterRepoHash();

  @$internal
  @override
  $ProviderElement<LocalSortFilterRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalSortFilterRepo create(Ref ref) {
    return localSortFilterRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalSortFilterRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalSortFilterRepo>(value),
    );
  }
}

String _$localSortFilterRepoHash() =>
    r'e400cbb2abb2c4d075c2b89020ab121bf66e5ce9';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
