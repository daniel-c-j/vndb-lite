// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_big_preview_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(CurrentHomeBigPreviewItemState)
const currentHomeBigPreviewItemStateProvider =
    CurrentHomeBigPreviewItemStateProvider._();

final class CurrentHomeBigPreviewItemStateProvider
    extends $NotifierProvider<CurrentHomeBigPreviewItemState, VnDataPhase01?> {
  const CurrentHomeBigPreviewItemStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentHomeBigPreviewItemStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentHomeBigPreviewItemStateHash();

  @$internal
  @override
  CurrentHomeBigPreviewItemState create() => CurrentHomeBigPreviewItemState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VnDataPhase01? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VnDataPhase01?>(value),
    );
  }
}

String _$currentHomeBigPreviewItemStateHash() =>
    r'982e631cc4e78a03870f27ad4a3cdc44a065faae';

abstract class _$CurrentHomeBigPreviewItemState
    extends $Notifier<VnDataPhase01?> {
  VnDataPhase01? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<VnDataPhase01?, VnDataPhase01?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VnDataPhase01?, VnDataPhase01?>,
              VnDataPhase01?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(HomeBigPreviewItemsState)
const homeBigPreviewItemsStateProvider = HomeBigPreviewItemsStateProvider._();

final class HomeBigPreviewItemsStateProvider
    extends $NotifierProvider<HomeBigPreviewItemsState, List<VnDataPhase01>> {
  const HomeBigPreviewItemsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeBigPreviewItemsStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeBigPreviewItemsStateHash();

  @$internal
  @override
  HomeBigPreviewItemsState create() => HomeBigPreviewItemsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<VnDataPhase01> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<VnDataPhase01>>(value),
    );
  }
}

String _$homeBigPreviewItemsStateHash() =>
    r'747759ef6101385d139aaeb8ee9520bde63e3c09';

abstract class _$HomeBigPreviewItemsState
    extends $Notifier<List<VnDataPhase01>> {
  List<VnDataPhase01> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<VnDataPhase01>, List<VnDataPhase01>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<VnDataPhase01>, List<VnDataPhase01>>,
              List<VnDataPhase01>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
