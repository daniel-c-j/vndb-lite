// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(getStatsChart)
const getStatsChartProvider = GetStatsChartProvider._();

final class GetStatsChartProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const GetStatsChartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getStatsChartProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          localChartRepoProvider,
          remoteChartRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          GetStatsChartProvider.$allTransitiveDependencies0,
          GetStatsChartProvider.$allTransitiveDependencies1,
          GetStatsChartProvider.$allTransitiveDependencies2,
          GetStatsChartProvider.$allTransitiveDependencies3,
          GetStatsChartProvider.$allTransitiveDependencies4,
        },
      );

  static const $allTransitiveDependencies0 = localChartRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalChartRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = remoteChartRepoProvider;
  static const $allTransitiveDependencies3 =
      RemoteChartRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      RemoteChartRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$getStatsChartHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return getStatsChart(ref);
  }
}

String _$getStatsChartHash() => r'6ff7d25704f7561c570d57edc1c48c74973fa843';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
