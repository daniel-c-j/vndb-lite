// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SearchResultPageController)
const searchResultPageControllerProvider =
    SearchResultPageControllerProvider._();

final class SearchResultPageControllerProvider
    extends $NotifierProvider<SearchResultPageController, int> {
  const SearchResultPageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultPageControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultPageControllerHash();

  @$internal
  @override
  SearchResultPageController create() => SearchResultPageController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$searchResultPageControllerHash() =>
    r'a94936348f29642b38d61bb6d9ce8775ad4bcb6e';

abstract class _$SearchResultPageController extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SearchResultController)
const searchResultControllerProvider = SearchResultControllerProvider._();

final class SearchResultControllerProvider
    extends $NotifierProvider<SearchResultController, List<VnItemGrid>> {
  const SearchResultControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultControllerHash();

  @$internal
  @override
  SearchResultController create() => SearchResultController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<VnItemGrid> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<VnItemGrid>>(value),
    );
  }
}

String _$searchResultControllerHash() =>
    r'17af13bcc98324358ce83d721948572c3d7707a3';

abstract class _$SearchResultController extends $Notifier<List<VnItemGrid>> {
  List<VnItemGrid> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<VnItemGrid>, List<VnItemGrid>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<VnItemGrid>, List<VnItemGrid>>,
              List<VnItemGrid>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
