// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_check_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(VersionCheckController)
const versionCheckControllerProvider = VersionCheckControllerProvider._();

final class VersionCheckControllerProvider
    extends $AsyncNotifierProvider<VersionCheckController, void> {
  const VersionCheckControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'versionCheckControllerProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          versionCheckRepoProvider,
          netErrorHandlerProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          VersionCheckControllerProvider.$allTransitiveDependencies0,
          VersionCheckControllerProvider.$allTransitiveDependencies1,
          VersionCheckControllerProvider.$allTransitiveDependencies2,
          VersionCheckControllerProvider.$allTransitiveDependencies3,
        },
      );

  static const $allTransitiveDependencies0 = versionCheckRepoProvider;
  static const $allTransitiveDependencies1 =
      VersionCheckRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      VersionCheckRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = netErrorHandlerProvider;

  @override
  String debugGetCreateSourceHash() => _$versionCheckControllerHash();

  @$internal
  @override
  VersionCheckController create() => VersionCheckController();
}

String _$versionCheckControllerHash() =>
    r'b2e45ca300b972570897a55fefe0c3166356c785';

abstract class _$VersionCheckController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
