// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_big_preview_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(CurrentHomeBigPreviewItem)
const currentHomeBigPreviewItemProvider = CurrentHomeBigPreviewItemProvider._();

final class CurrentHomeBigPreviewItemProvider
    extends $NotifierProvider<CurrentHomeBigPreviewItem, VnDataPhase01?> {
  const CurrentHomeBigPreviewItemProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentHomeBigPreviewItemProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentHomeBigPreviewItemHash();

  @$internal
  @override
  CurrentHomeBigPreviewItem create() => CurrentHomeBigPreviewItem();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VnDataPhase01? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VnDataPhase01?>(value),
    );
  }
}

String _$currentHomeBigPreviewItemHash() =>
    r'7cc69242300df35482a65f2992d369b791566eea';

abstract class _$CurrentHomeBigPreviewItem extends $Notifier<VnDataPhase01?> {
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

@ProviderFor(HomeBigPreviewItems)
const homeBigPreviewItemsProvider = HomeBigPreviewItemsProvider._();

final class HomeBigPreviewItemsProvider
    extends $NotifierProvider<HomeBigPreviewItems, List<VnDataPhase01>> {
  const HomeBigPreviewItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeBigPreviewItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeBigPreviewItemsHash();

  @$internal
  @override
  HomeBigPreviewItems create() => HomeBigPreviewItems();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<VnDataPhase01> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<VnDataPhase01>>(value),
    );
  }
}

String _$homeBigPreviewItemsHash() =>
    r'3eb9928a217edd2f79dd8b64e474189b36cd38d7';

abstract class _$HomeBigPreviewItems extends $Notifier<List<VnDataPhase01>> {
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
