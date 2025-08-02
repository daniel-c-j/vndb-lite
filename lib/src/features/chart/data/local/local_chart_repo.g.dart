// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_chart_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localChartRepo)
const localChartRepoProvider = LocalChartRepoProvider._();

final class LocalChartRepoProvider
    extends $FunctionalProvider<LocalChartRepo, LocalChartRepo, LocalChartRepo>
    with $Provider<LocalChartRepo> {
  const LocalChartRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localChartRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          LocalChartRepoProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$localChartRepoHash();

  @$internal
  @override
  $ProviderElement<LocalChartRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalChartRepo create(Ref ref) {
    return localChartRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalChartRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalChartRepo>(value),
    );
  }
}

String _$localChartRepoHash() => r'9ff82a04c91a101862281936d2d64e245da1a68d';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
