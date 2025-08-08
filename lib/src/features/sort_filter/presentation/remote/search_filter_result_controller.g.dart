// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_filter_result_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(DevSearchState)
const devSearchStateProvider = DevSearchStateProvider._();

final class DevSearchStateProvider
    extends $NotifierProvider<DevSearchState, String> {
  const DevSearchStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devSearchStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devSearchStateHash();

  @$internal
  @override
  DevSearchState create() => DevSearchState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$devSearchStateHash() => r'37630010a8c9351b0812c6837ba473415752cac3';

abstract class _$DevSearchState extends $Notifier<String> {
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

@ProviderFor(TagSearchState)
const tagSearchStateProvider = TagSearchStateProvider._();

final class TagSearchStateProvider
    extends $NotifierProvider<TagSearchState, String> {
  const TagSearchStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagSearchStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagSearchStateHash();

  @$internal
  @override
  TagSearchState create() => TagSearchState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$tagSearchStateHash() => r'c82044d4132205bcdc90353d90abb1a202538e82';

abstract class _$TagSearchState extends $Notifier<String> {
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
