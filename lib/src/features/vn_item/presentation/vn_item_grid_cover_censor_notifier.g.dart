// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_item_grid_cover_censor_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VnItemGridCoverCensorNotifier)
const vnItemGridCoverCensorNotifierProvider =
    VnItemGridCoverCensorNotifierFamily._();

final class VnItemGridCoverCensorNotifierProvider
    extends $NotifierProvider<VnItemGridCoverCensorNotifier, bool?> {
  const VnItemGridCoverCensorNotifierProvider._({
    required VnItemGridCoverCensorNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vnItemGridCoverCensorNotifierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vnItemGridCoverCensorNotifierHash();

  @override
  String toString() {
    return r'vnItemGridCoverCensorNotifierProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VnItemGridCoverCensorNotifier create() => VnItemGridCoverCensorNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VnItemGridCoverCensorNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vnItemGridCoverCensorNotifierHash() =>
    r'd3fa9d3f71a4065f933c5e85dcff8a598266f86a';

final class VnItemGridCoverCensorNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          VnItemGridCoverCensorNotifier,
          bool?,
          bool?,
          bool?,
          String
        > {
  const VnItemGridCoverCensorNotifierFamily._()
    : super(
        retry: null,
        name: r'vnItemGridCoverCensorNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VnItemGridCoverCensorNotifierProvider call(String vnId) =>
      VnItemGridCoverCensorNotifierProvider._(argument: vnId, from: this);

  @override
  String toString() => r'vnItemGridCoverCensorNotifierProvider';
}

abstract class _$VnItemGridCoverCensorNotifier extends $Notifier<bool?> {
  late final _$args = ref.$arg as String;
  String get vnId => _$args;

  bool? build(String vnId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<bool?, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool?, bool?>,
              bool?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
