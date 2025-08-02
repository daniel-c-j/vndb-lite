// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_collection_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localCollectionRepo)
const localCollectionRepoProvider = LocalCollectionRepoProvider._();

final class LocalCollectionRepoProvider
    extends
        $FunctionalProvider<
          LocalCollectionRepo,
          LocalCollectionRepo,
          LocalCollectionRepo
        >
    with $Provider<LocalCollectionRepo> {
  const LocalCollectionRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localCollectionRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          sharedPrefProvider,
          localHomeRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          LocalCollectionRepoProvider.$allTransitiveDependencies0,
          LocalCollectionRepoProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;
  static const $allTransitiveDependencies1 = localHomeRepoProvider;

  @override
  String debugGetCreateSourceHash() => _$localCollectionRepoHash();

  @$internal
  @override
  $ProviderElement<LocalCollectionRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalCollectionRepo create(Ref ref) {
    return localCollectionRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalCollectionRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalCollectionRepo>(value),
    );
  }
}

String _$localCollectionRepoHash() =>
    r'e0cde70bae10d3ff966facd32eb15e81ce0a9deb';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
