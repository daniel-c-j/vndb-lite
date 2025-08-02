// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_selection_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(vnSelectionService)
const vnSelectionServiceProvider = VnSelectionServiceProvider._();

final class VnSelectionServiceProvider
    extends
        $FunctionalProvider<
          VnSelectionService,
          VnSelectionService,
          VnSelectionService
        >
    with $Provider<VnSelectionService> {
  const VnSelectionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vnSelectionServiceProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          localVnRepoProvider,
          localSyncRepoProvider,
          fetchAndSaveP2DataProvider,
          localCollectionRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          VnSelectionServiceProvider.$allTransitiveDependencies0,
          VnSelectionServiceProvider.$allTransitiveDependencies1,
          VnSelectionServiceProvider.$allTransitiveDependencies2,
          VnSelectionServiceProvider.$allTransitiveDependencies3,
          VnSelectionServiceProvider.$allTransitiveDependencies4,
          VnSelectionServiceProvider.$allTransitiveDependencies5,
          VnSelectionServiceProvider.$allTransitiveDependencies6,
          VnSelectionServiceProvider.$allTransitiveDependencies7,
          VnSelectionServiceProvider.$allTransitiveDependencies8,
        },
      );

  static const $allTransitiveDependencies0 = localVnRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalVnRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = localSyncRepoProvider;
  static const $allTransitiveDependencies3 = fetchAndSaveP2DataProvider;
  static const $allTransitiveDependencies4 =
      FetchAndSaveP2DataProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies5 =
      FetchAndSaveP2DataProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies6 =
      FetchAndSaveP2DataProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies7 = localCollectionRepoProvider;
  static const $allTransitiveDependencies8 =
      LocalCollectionRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$vnSelectionServiceHash();

  @$internal
  @override
  $ProviderElement<VnSelectionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VnSelectionService create(Ref ref) {
    return vnSelectionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VnSelectionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VnSelectionService>(value),
    );
  }
}

String _$vnSelectionServiceHash() =>
    r'95995de4660445a7b52adeafba51310bc296e103';

@ProviderFor(confirmSelection)
const confirmSelectionProvider = ConfirmSelectionFamily._();

final class ConfirmSelectionProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const ConfirmSelectionProvider._({
    required ConfirmSelectionFamily super.from,
    required ({
      List<VnDataPhase01> p1List,
      Map<String, VnRecord?> vnRecords,
      VnSelection selection,
      VoidCallback whenSuccess,
      Function(Object, StackTrace) whenErr,
      void Function(String) saveRefresh,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'confirmSelectionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
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
  String debugGetCreateSourceHash() => _$confirmSelectionHash();

  @override
  String toString() {
    return r'confirmSelectionProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument =
        this.argument
            as ({
              List<VnDataPhase01> p1List,
              Map<String, VnRecord?> vnRecords,
              VnSelection selection,
              VoidCallback whenSuccess,
              Function(Object, StackTrace) whenErr,
              void Function(String) saveRefresh,
            });
    return confirmSelection(
      ref,
      p1List: argument.p1List,
      vnRecords: argument.vnRecords,
      selection: argument.selection,
      whenSuccess: argument.whenSuccess,
      whenErr: argument.whenErr,
      saveRefresh: argument.saveRefresh,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ConfirmSelectionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$confirmSelectionHash() => r'7f8bcf81337ecd7c912a97ebef20d7af823b541d';

final class ConfirmSelectionFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          ({
            List<VnDataPhase01> p1List,
            Map<String, VnRecord?> vnRecords,
            VnSelection selection,
            VoidCallback whenSuccess,
            Function(Object, StackTrace) whenErr,
            void Function(String) saveRefresh,
          })
        > {
  const ConfirmSelectionFamily._()
    : super(
        retry: null,
        name: r'confirmSelectionProvider',
        dependencies: const <ProviderOrFamily>[vnSelectionServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ConfirmSelectionProvider.$allTransitiveDependencies0,
          ConfirmSelectionProvider.$allTransitiveDependencies1,
          ConfirmSelectionProvider.$allTransitiveDependencies2,
          ConfirmSelectionProvider.$allTransitiveDependencies3,
          ConfirmSelectionProvider.$allTransitiveDependencies4,
          ConfirmSelectionProvider.$allTransitiveDependencies5,
          ConfirmSelectionProvider.$allTransitiveDependencies6,
          ConfirmSelectionProvider.$allTransitiveDependencies7,
          ConfirmSelectionProvider.$allTransitiveDependencies8,
          ConfirmSelectionProvider.$allTransitiveDependencies9,
        },
        isAutoDispose: true,
      );

  ConfirmSelectionProvider call({
    required List<VnDataPhase01> p1List,
    required Map<String, VnRecord?> vnRecords,
    required VnSelection selection,
    required VoidCallback whenSuccess,
    required Function(Object, StackTrace) whenErr,
    required void Function(String) saveRefresh,
  }) => ConfirmSelectionProvider._(
    argument: (
      p1List: p1List,
      vnRecords: vnRecords,
      selection: selection,
      whenSuccess: whenSuccess,
      whenErr: whenErr,
      saveRefresh: saveRefresh,
    ),
    from: this,
  );

  @override
  String toString() => r'confirmSelectionProvider';
}

@ProviderFor(removeSelection)
const removeSelectionProvider = RemoveSelectionFamily._();

final class RemoveSelectionProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const RemoveSelectionProvider._({
    required RemoveSelectionFamily super.from,
    required (
      List<VnRecord?>, {
      VoidCallback whenSuccess,
      void Function(String) removeRefresh,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'removeSelectionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
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
  String debugGetCreateSourceHash() => _$removeSelectionHash();

  @override
  String toString() {
    return r'removeSelectionProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument =
        this.argument
            as (
              List<VnRecord?>, {
              VoidCallback whenSuccess,
              void Function(String) removeRefresh,
            });
    return removeSelection(
      ref,
      argument.$1,
      whenSuccess: argument.whenSuccess,
      removeRefresh: argument.removeRefresh,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveSelectionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$removeSelectionHash() => r'47fb3fef49d033507061f7e220d9b17ebb20b0dd';

final class RemoveSelectionFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<void>,
          (
            List<VnRecord?>, {
            VoidCallback whenSuccess,
            void Function(String) removeRefresh,
          })
        > {
  const RemoveSelectionFamily._()
    : super(
        retry: null,
        name: r'removeSelectionProvider',
        dependencies: const <ProviderOrFamily>[vnSelectionServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          RemoveSelectionProvider.$allTransitiveDependencies0,
          RemoveSelectionProvider.$allTransitiveDependencies1,
          RemoveSelectionProvider.$allTransitiveDependencies2,
          RemoveSelectionProvider.$allTransitiveDependencies3,
          RemoveSelectionProvider.$allTransitiveDependencies4,
          RemoveSelectionProvider.$allTransitiveDependencies5,
          RemoveSelectionProvider.$allTransitiveDependencies6,
          RemoveSelectionProvider.$allTransitiveDependencies7,
          RemoveSelectionProvider.$allTransitiveDependencies8,
          RemoveSelectionProvider.$allTransitiveDependencies9,
        },
        isAutoDispose: true,
      );

  RemoveSelectionProvider call(
    List<VnRecord?> vnRecords, {
    required VoidCallback whenSuccess,
    required void Function(String) removeRefresh,
  }) => RemoveSelectionProvider._(
    argument: (
      vnRecords,
      whenSuccess: whenSuccess,
      removeRefresh: removeRefresh,
    ),
    from: this,
  );

  @override
  String toString() => r'removeSelectionProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
