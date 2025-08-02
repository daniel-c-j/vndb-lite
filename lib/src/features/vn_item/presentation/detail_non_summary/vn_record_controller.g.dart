// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VnRecordController)
const vnRecordControllerProvider = VnRecordControllerFamily._();

final class VnRecordControllerProvider
    extends $NotifierProvider<VnRecordController, VnRecord?> {
  const VnRecordControllerProvider._({
    required VnRecordControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vnRecordControllerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = localCollectionRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalCollectionRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      LocalCollectionRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$vnRecordControllerHash();

  @override
  String toString() {
    return r'vnRecordControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VnRecordController create() => VnRecordController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VnRecord? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VnRecord?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VnRecordControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vnRecordControllerHash() =>
    r'bf283ed71d8a8678f984951a227381fc047aee71';

final class VnRecordControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          VnRecordController,
          VnRecord?,
          VnRecord?,
          VnRecord?,
          String
        > {
  const VnRecordControllerFamily._()
    : super(
        retry: null,
        name: r'vnRecordControllerProvider',
        dependencies: const <ProviderOrFamily>[localCollectionRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          VnRecordControllerProvider.$allTransitiveDependencies0,
          VnRecordControllerProvider.$allTransitiveDependencies1,
          VnRecordControllerProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: false,
      );

  VnRecordControllerProvider call(String vnId) =>
      VnRecordControllerProvider._(argument: vnId, from: this);

  @override
  String toString() => r'vnRecordControllerProvider';
}

abstract class _$VnRecordController extends $Notifier<VnRecord?> {
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
