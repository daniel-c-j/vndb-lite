// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_sort_filter_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LocalFilterController)
const localFilterControllerProvider = LocalFilterControllerProvider._();

final class LocalFilterControllerProvider
    extends $NotifierProvider<LocalFilterController, FilterData> {
  const LocalFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localFilterControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[localSortFilterRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          LocalFilterControllerProvider.$allTransitiveDependencies0,
          LocalFilterControllerProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = localSortFilterRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalSortFilterRepoProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$localFilterControllerHash();

  @$internal
  @override
  LocalFilterController create() => LocalFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FilterData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FilterData>(value),
    );
  }
}

String _$localFilterControllerHash() =>
    r'194bfc052fa0a9a2290f4ed88d468eb52b130144';

abstract class _$LocalFilterController extends $Notifier<FilterData> {
  FilterData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FilterData, FilterData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FilterData, FilterData>,
              FilterData,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(LocalSortController)
const localSortControllerProvider = LocalSortControllerProvider._();

final class LocalSortControllerProvider
    extends $NotifierProvider<LocalSortController, SortData> {
  const LocalSortControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localSortControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[localSortFilterRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          LocalSortControllerProvider.$allTransitiveDependencies0,
          LocalSortControllerProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = localSortFilterRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalSortFilterRepoProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$localSortControllerHash();

  @$internal
  @override
  LocalSortController create() => LocalSortController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SortData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SortData>(value),
    );
  }
}

String _$localSortControllerHash() =>
    r'69e9bdcb76f6adc960120b1b15e7f64c0987cfe6';

abstract class _$LocalSortController extends $Notifier<SortData> {
  SortData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SortData, SortData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SortData, SortData>,
              SortData,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
