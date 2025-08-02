// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_filter_result_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(DevSearchController)
const devSearchControllerProvider = DevSearchControllerProvider._();

final class DevSearchControllerProvider
    extends $NotifierProvider<DevSearchController, String> {
  const DevSearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devSearchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devSearchControllerHash();

  @$internal
  @override
  DevSearchController create() => DevSearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$devSearchControllerHash() =>
    r'c326b597bfec9df5b82ad3e37a6209b1b13b1314';

abstract class _$DevSearchController extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TagSearchController)
const tagSearchControllerProvider = TagSearchControllerProvider._();

final class TagSearchControllerProvider
    extends $NotifierProvider<TagSearchController, String> {
  const TagSearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagSearchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagSearchControllerHash();

  @$internal
  @override
  TagSearchController create() => TagSearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$tagSearchControllerHash() =>
    r'b99b564f5c9978c61c7491d72e155f67aa6de87f';

abstract class _$TagSearchController extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
