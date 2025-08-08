// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_selection_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VnSelectionController)
const vnSelectionControllerProvider = VnSelectionControllerProvider._();

final class VnSelectionControllerProvider
    extends $NotifierProvider<VnSelectionController, VnSelection> {
  const VnSelectionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vnSelectionControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[vnSelectionServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          VnSelectionControllerProvider.$allTransitiveDependencies0,
          VnSelectionControllerProvider.$allTransitiveDependencies1,
          VnSelectionControllerProvider.$allTransitiveDependencies2,
          VnSelectionControllerProvider.$allTransitiveDependencies3,
          VnSelectionControllerProvider.$allTransitiveDependencies4,
          VnSelectionControllerProvider.$allTransitiveDependencies5,
          VnSelectionControllerProvider.$allTransitiveDependencies6,
          VnSelectionControllerProvider.$allTransitiveDependencies7,
          VnSelectionControllerProvider.$allTransitiveDependencies8,
          VnSelectionControllerProvider.$allTransitiveDependencies9,
        },
      );

  static const $allTransitiveDependencies0 = vnSelectionServiceProvider;
  static const $allTransitiveDependencies1 =
      VnSelectionServiceProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      VnSelectionServiceProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      VnSelectionServiceProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      VnSelectionServiceProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      VnSelectionServiceProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies6 =
      VnSelectionServiceProvider.$allTransitiveDependencies5;
  static const $allTransitiveDependencies7 =
      VnSelectionServiceProvider.$allTransitiveDependencies6;
  static const $allTransitiveDependencies8 =
      VnSelectionServiceProvider.$allTransitiveDependencies7;
  static const $allTransitiveDependencies9 =
      VnSelectionServiceProvider.$allTransitiveDependencies8;

  @override
  String debugGetCreateSourceHash() => _$vnSelectionControllerHash();

  @$internal
  @override
  VnSelectionController create() => VnSelectionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VnSelection value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VnSelection>(value),
    );
  }
}

String _$vnSelectionControllerHash() =>
    r'ed8482085865fec0f26645754356c32c5480ef5c';

abstract class _$VnSelectionController extends $Notifier<VnSelection> {
  VnSelection build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<VnSelection, VnSelection>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VnSelection, VnSelection>,
              VnSelection,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
