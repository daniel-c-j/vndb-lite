// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_detail_screenshots_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VnDetailScreenshotState)
const vnDetailScreenshotStateProvider = VnDetailScreenshotStateProvider._();

final class VnDetailScreenshotStateProvider
    extends $NotifierProvider<VnDetailScreenshotState, bool> {
  const VnDetailScreenshotStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vnDetailScreenshotStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vnDetailScreenshotStateHash();

  @$internal
  @override
  VnDetailScreenshotState create() => VnDetailScreenshotState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$vnDetailScreenshotStateHash() =>
    r'3d0484a2781155e7aedea9a8ad890a1e326b4446';

abstract class _$VnDetailScreenshotState extends $Notifier<bool> {
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
