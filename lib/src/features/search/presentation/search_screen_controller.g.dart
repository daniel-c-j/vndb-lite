// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_screen_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SearchResultNotifier)
const searchResultNotifierProvider = SearchResultNotifierProvider._();

final class SearchResultNotifierProvider
    extends $NotifierProvider<SearchResultNotifier, bool> {
  const SearchResultNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultNotifierHash();

  @$internal
  @override
  SearchResultNotifier create() => SearchResultNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$searchResultNotifierHash() =>
    r'68211ca6147bde5a9b489a144262c6a242d26a54';

abstract class _$SearchResultNotifier extends $Notifier<bool> {
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

@ProviderFor(SearchScreenController)
const searchScreenControllerProvider = SearchScreenControllerProvider._();

final class SearchScreenControllerProvider
    extends $NotifierProvider<SearchScreenController, List<Widget>> {
  const SearchScreenControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchScreenControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchScreenControllerHash();

  @$internal
  @override
  SearchScreenController create() => SearchScreenController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Widget> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Widget>>(value),
    );
  }
}

String _$searchScreenControllerHash() =>
    r'423e7c9bd46abd5187005e8a4d7b5a72e4234750';

abstract class _$SearchScreenController extends $Notifier<List<Widget>> {
  List<Widget> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Widget>, List<Widget>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Widget>, List<Widget>>,
              List<Widget>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
