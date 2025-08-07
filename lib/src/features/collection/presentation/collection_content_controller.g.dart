// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_content_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// This notifier is to forcefully update the UI.
@ProviderFor(CollectionContentNotifier)
const collectionContentNotifierProvider = CollectionContentNotifierProvider._();

/// This notifier is to forcefully update the UI.
final class CollectionContentNotifierProvider
    extends $NotifierProvider<CollectionContentNotifier, bool> {
  /// This notifier is to forcefully update the UI.
  const CollectionContentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionContentNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionContentNotifierHash();

  @$internal
  @override
  CollectionContentNotifier create() => CollectionContentNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$collectionContentNotifierHash() =>
    r'6a5b33b5a81e5aa30d86b7449d8efbca3fb1af0b';

abstract class _$CollectionContentNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(CollectionContentController)
const collectionContentControllerProvider =
    CollectionContentControllerProvider._();

final class CollectionContentControllerProvider
    extends
        $NotifierProvider<
          CollectionContentController,
          Map<String, List<VnItemGrid>>
        > {
  const CollectionContentControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionContentControllerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[
          collectionSortFilterServiceProvider,
          localCollectionRepoProvider,
          sharedPrefProvider,
          localVnRepoProvider,
          validateVnAndSaveToLocalProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          CollectionContentControllerProvider.$allTransitiveDependencies0,
          CollectionContentControllerProvider.$allTransitiveDependencies1,
          CollectionContentControllerProvider.$allTransitiveDependencies2,
          CollectionContentControllerProvider.$allTransitiveDependencies3,
          CollectionContentControllerProvider.$allTransitiveDependencies4,
          CollectionContentControllerProvider.$allTransitiveDependencies5,
          CollectionContentControllerProvider.$allTransitiveDependencies6,
          CollectionContentControllerProvider.$allTransitiveDependencies7,
          CollectionContentControllerProvider.$allTransitiveDependencies8,
          CollectionContentControllerProvider.$allTransitiveDependencies9,
        },
      );

  static const $allTransitiveDependencies0 =
      collectionSortFilterServiceProvider;
  static const $allTransitiveDependencies1 =
      CollectionSortFilterServiceProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = localCollectionRepoProvider;
  static const $allTransitiveDependencies3 =
      LocalCollectionRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      LocalCollectionRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies5 = localVnRepoProvider;
  static const $allTransitiveDependencies6 = validateVnAndSaveToLocalProvider;
  static const $allTransitiveDependencies7 =
      ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies8 =
      ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies9 =
      ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies2;

  @override
  String debugGetCreateSourceHash() => _$collectionContentControllerHash();

  @$internal
  @override
  CollectionContentController create() => CollectionContentController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, List<VnItemGrid>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, List<VnItemGrid>>>(
        value,
      ),
    );
  }
}

String _$collectionContentControllerHash() =>
    r'2f2e435c8cbbf030f3faed3e0393d388d8d50a7a';

abstract class _$CollectionContentController
    extends $Notifier<Map<String, List<VnItemGrid>>> {
  Map<String, List<VnItemGrid>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              Map<String, List<VnItemGrid>>,
              Map<String, List<VnItemGrid>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, List<VnItemGrid>>,
                Map<String, List<VnItemGrid>>
              >,
              Map<String, List<VnItemGrid>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
