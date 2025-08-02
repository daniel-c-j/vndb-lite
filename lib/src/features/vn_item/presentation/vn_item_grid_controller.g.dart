// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_item_grid_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VnItemGridCoverCensorState)
const vnItemGridCoverCensorStateProvider = VnItemGridCoverCensorStateFamily._();

final class VnItemGridCoverCensorStateProvider
    extends $NotifierProvider<VnItemGridCoverCensorState, bool> {
  const VnItemGridCoverCensorStateProvider._({
    required VnItemGridCoverCensorStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vnItemGridCoverCensorStateProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vnItemGridCoverCensorStateHash();

  @override
  String toString() {
    return r'vnItemGridCoverCensorStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VnItemGridCoverCensorState create() => VnItemGridCoverCensorState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VnItemGridCoverCensorStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vnItemGridCoverCensorStateHash() =>
    r'36e4354f6c78098a9044491c614b837522a083cb';

final class VnItemGridCoverCensorStateFamily extends $Family
    with
        $ClassFamilyOverride<
          VnItemGridCoverCensorState,
          bool,
          bool,
          bool,
          String
        > {
  const VnItemGridCoverCensorStateFamily._()
    : super(
        retry: null,
        name: r'vnItemGridCoverCensorStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  VnItemGridCoverCensorStateProvider call(String vnId) =>
      VnItemGridCoverCensorStateProvider._(argument: vnId, from: this);

  @override
  String toString() => r'vnItemGridCoverCensorStateProvider';
}

abstract class _$VnItemGridCoverCensorState extends $Notifier<bool> {
  late final _$args = ref.$arg as String;
  String get vnId => _$args;

  bool build(String vnId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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

@ProviderFor(VnItemGridAlmostLongPressedState)
const vnItemGridAlmostLongPressedStateProvider =
    VnItemGridAlmostLongPressedStateProvider._();

final class VnItemGridAlmostLongPressedStateProvider
    extends $NotifierProvider<VnItemGridAlmostLongPressedState, String> {
  const VnItemGridAlmostLongPressedStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vnItemGridAlmostLongPressedStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vnItemGridAlmostLongPressedStateHash();

  @$internal
  @override
  VnItemGridAlmostLongPressedState create() =>
      VnItemGridAlmostLongPressedState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$vnItemGridAlmostLongPressedStateHash() =>
    r'ef6b02aad8cf723f61e558cb42897b593b5209f2';

abstract class _$VnItemGridAlmostLongPressedState extends $Notifier<String> {
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
