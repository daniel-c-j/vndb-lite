// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_chart_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(remoteChartRepo)
const remoteChartRepoProvider = RemoteChartRepoProvider._();

final class RemoteChartRepoProvider
    extends
        $FunctionalProvider<RemoteChartRepo, RemoteChartRepo, RemoteChartRepo>
    with $Provider<RemoteChartRepo> {
  const RemoteChartRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteChartRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[apiServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          RemoteChartRepoProvider.$allTransitiveDependencies0,
          RemoteChartRepoProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = apiServiceProvider;
  static const $allTransitiveDependencies1 =
      ApiServiceProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$remoteChartRepoHash();

  @$internal
  @override
  $ProviderElement<RemoteChartRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RemoteChartRepo create(Ref ref) {
    return remoteChartRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteChartRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteChartRepo>(value),
    );
  }
}

String _$remoteChartRepoHash() => r'129c063f4e1cccca32059b19eedb06c322e38a29';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
