// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_selected_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(RecordSelectedController)
const recordSelectedControllerProvider = RecordSelectedControllerProvider._();

final class RecordSelectedControllerProvider
    extends $NotifierProvider<RecordSelectedController, List<String>> {
  const RecordSelectedControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recordSelectedControllerProvider',
        isAutoDispose: false,
        dependencies: const <ProviderOrFamily>[localVnRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          RecordSelectedControllerProvider.$allTransitiveDependencies0,
          RecordSelectedControllerProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = localVnRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalVnRepoProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$recordSelectedControllerHash();

  @$internal
  @override
  RecordSelectedController create() => RecordSelectedController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$recordSelectedControllerHash() =>
    r'fbfb7b1b539870dfbc841a456b08e8b454bff18e';

abstract class _$RecordSelectedController extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
