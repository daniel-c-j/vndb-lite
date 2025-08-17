// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_vn_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(randomVnRepo)
const randomVnRepoProvider = RandomVnRepoProvider._();

final class RandomVnRepoProvider
    extends $FunctionalProvider<RandomVnRepo, RandomVnRepo, RandomVnRepo>
    with $Provider<RandomVnRepo> {
  const RandomVnRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'randomVnRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[apiServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          RandomVnRepoProvider.$allTransitiveDependencies0,
          RandomVnRepoProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = apiServiceProvider;
  static const $allTransitiveDependencies1 =
      ApiServiceProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$randomVnRepoHash();

  @$internal
  @override
  $ProviderElement<RandomVnRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RandomVnRepo create(Ref ref) {
    return randomVnRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RandomVnRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RandomVnRepo>(value),
    );
  }
}

String _$randomVnRepoHash() => r'0edab3fa736ccefa5a0c6b5822312c3e464b9bfb';

@ProviderFor(generateRandomVn)
const generateRandomVnProvider = GenerateRandomVnProvider._();

final class GenerateRandomVnProvider
    extends
        $FunctionalProvider<
          AsyncValue<VnDataPhase01>,
          VnDataPhase01,
          FutureOr<VnDataPhase01>
        >
    with $FutureModifier<VnDataPhase01>, $FutureProvider<VnDataPhase01> {
  const GenerateRandomVnProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generateRandomVnProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[randomVnRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          GenerateRandomVnProvider.$allTransitiveDependencies0,
          GenerateRandomVnProvider.$allTransitiveDependencies1,
          GenerateRandomVnProvider.$allTransitiveDependencies2,
        ],
      );

  static const $allTransitiveDependencies0 = randomVnRepoProvider;
  static const $allTransitiveDependencies1 =
      RandomVnRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RandomVnRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$generateRandomVnHash();

  @$internal
  @override
  $FutureProviderElement<VnDataPhase01> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VnDataPhase01> create(Ref ref) {
    return generateRandomVn(ref);
  }
}

String _$generateRandomVnHash() => r'dd4eff9a1c9d5c663ced9cf11eb7235819b59d25';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
