// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_item_grid_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$vnItemGridCoverCensorStateHash() =>
    r'36e4354f6c78098a9044491c614b837522a083cb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$VnItemGridCoverCensorState extends BuildlessNotifier<bool> {
  late final String vnId;

  bool build(String vnId);
}

/// See also [VnItemGridCoverCensorState].
@ProviderFor(VnItemGridCoverCensorState)
const vnItemGridCoverCensorStateProvider = VnItemGridCoverCensorStateFamily();

/// See also [VnItemGridCoverCensorState].
class VnItemGridCoverCensorStateFamily extends Family<bool> {
  /// See also [VnItemGridCoverCensorState].
  const VnItemGridCoverCensorStateFamily();

  /// See also [VnItemGridCoverCensorState].
  VnItemGridCoverCensorStateProvider call(String vnId) {
    return VnItemGridCoverCensorStateProvider(vnId);
  }

  @override
  VnItemGridCoverCensorStateProvider getProviderOverride(
    covariant VnItemGridCoverCensorStateProvider provider,
  ) {
    return call(provider.vnId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'vnItemGridCoverCensorStateProvider';
}

/// See also [VnItemGridCoverCensorState].
class VnItemGridCoverCensorStateProvider
    extends NotifierProviderImpl<VnItemGridCoverCensorState, bool> {
  /// See also [VnItemGridCoverCensorState].
  VnItemGridCoverCensorStateProvider(String vnId)
    : this._internal(
        () => VnItemGridCoverCensorState()..vnId = vnId,
        from: vnItemGridCoverCensorStateProvider,
        name: r'vnItemGridCoverCensorStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$vnItemGridCoverCensorStateHash,
        dependencies: VnItemGridCoverCensorStateFamily._dependencies,
        allTransitiveDependencies:
            VnItemGridCoverCensorStateFamily._allTransitiveDependencies,
        vnId: vnId,
      );

  VnItemGridCoverCensorStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.vnId,
  }) : super.internal();

  final String vnId;

  @override
  bool runNotifierBuild(covariant VnItemGridCoverCensorState notifier) {
    return notifier.build(vnId);
  }

  @override
  Override overrideWith(VnItemGridCoverCensorState Function() create) {
    return ProviderOverride(
      origin: this,
      override: VnItemGridCoverCensorStateProvider._internal(
        () => create()..vnId = vnId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        vnId: vnId,
      ),
    );
  }

  @override
  NotifierProviderElement<VnItemGridCoverCensorState, bool> createElement() {
    return _VnItemGridCoverCensorStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VnItemGridCoverCensorStateProvider && other.vnId == vnId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, vnId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VnItemGridCoverCensorStateRef on NotifierProviderRef<bool> {
  /// The parameter `vnId` of this provider.
  String get vnId;
}

class _VnItemGridCoverCensorStateProviderElement
    extends NotifierProviderElement<VnItemGridCoverCensorState, bool>
    with VnItemGridCoverCensorStateRef {
  _VnItemGridCoverCensorStateProviderElement(super.provider);

  @override
  String get vnId => (origin as VnItemGridCoverCensorStateProvider).vnId;
}

String _$vnItemGridAlmostLongPressedStateHash() =>
    r'ef6b02aad8cf723f61e558cb42897b593b5209f2';

/// See also [VnItemGridAlmostLongPressedState].
@ProviderFor(VnItemGridAlmostLongPressedState)
final vnItemGridAlmostLongPressedStateProvider = AutoDisposeNotifierProvider<
  VnItemGridAlmostLongPressedState,
  String
>.internal(
  VnItemGridAlmostLongPressedState.new,
  name: r'vnItemGridAlmostLongPressedStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$vnItemGridAlmostLongPressedStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VnItemGridAlmostLongPressedState = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
