// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_record_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VnRecordState)
const vnRecordStateProvider = VnRecordStateFamily._();

final class VnRecordStateProvider
    extends $NotifierProvider<VnRecordState, VnRecord?> {
  const VnRecordStateProvider._({
    required VnRecordStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vnRecordStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = localCollectionRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalCollectionRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      LocalCollectionRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$vnRecordStateHash();

  @override
  String toString() {
    return r'vnRecordStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VnRecordState create() => VnRecordState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VnRecord? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VnRecord?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VnRecordStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vnRecordStateHash() => r'cdae351f8c800daed60c2249243a63d79b925e0c';

final class VnRecordStateFamily extends $Family
    with
        $ClassFamilyOverride<
          VnRecordState,
          VnRecord?,
          VnRecord?,
          VnRecord?,
          String
        > {
  const VnRecordStateFamily._()
    : super(
        retry: null,
        name: r'vnRecordStateProvider',
        dependencies: const <ProviderOrFamily>[localCollectionRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          VnRecordStateProvider.$allTransitiveDependencies0,
          VnRecordStateProvider.$allTransitiveDependencies1,
          VnRecordStateProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: true,
      );

  VnRecordStateProvider call(String vnId) =>
      VnRecordStateProvider._(argument: vnId, from: this);

  @override
  String toString() => r'vnRecordStateProvider';
}

abstract class _$VnRecordState extends $Notifier<VnRecord?> {
  late final _$args = ref.$arg as String;
  String get vnId => _$args;

  VnRecord? build(String vnId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<VnRecord?, VnRecord?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VnRecord?, VnRecord?>,
              VnRecord?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
