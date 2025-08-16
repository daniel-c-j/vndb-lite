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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
