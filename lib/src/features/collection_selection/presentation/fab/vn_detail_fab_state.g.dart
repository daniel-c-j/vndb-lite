// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_detail_fab_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VnDetailFabState)
const vnDetailFabStateProvider = VnDetailFabStateFamily._();

final class VnDetailFabStateProvider
    extends $NotifierProvider<VnDetailFabState, bool> {
  const VnDetailFabStateProvider._({
    required VnDetailFabStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vnDetailFabStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vnDetailFabStateHash();

  @override
  String toString() {
    return r'vnDetailFabStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VnDetailFabState create() => VnDetailFabState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VnDetailFabStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vnDetailFabStateHash() => r'80a13002cd24b41a198c7d7a6ecb1f5871221a78';

final class VnDetailFabStateFamily extends $Family
    with $ClassFamilyOverride<VnDetailFabState, bool, bool, bool, String> {
  const VnDetailFabStateFamily._()
    : super(
        retry: null,
        name: r'vnDetailFabStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VnDetailFabStateProvider call(String vnId) =>
      VnDetailFabStateProvider._(argument: vnId, from: this);

  @override
  String toString() => r'vnDetailFabStateProvider';
}

abstract class _$VnDetailFabState extends $Notifier<bool> {
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
