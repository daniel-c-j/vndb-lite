// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_vn_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localVnRepo)
const localVnRepoProvider = LocalVnRepoProvider._();

final class LocalVnRepoProvider
    extends $FunctionalProvider<LocalVnRepo, LocalVnRepo, LocalVnRepo>
    with $Provider<LocalVnRepo> {
  const LocalVnRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localVnRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[sharedPrefProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          LocalVnRepoProvider.$allTransitiveDependencies0,
        ],
      );

  static const $allTransitiveDependencies0 = sharedPrefProvider;

  @override
  String debugGetCreateSourceHash() => _$localVnRepoHash();

  @$internal
  @override
  $ProviderElement<LocalVnRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalVnRepo create(Ref ref) {
    return localVnRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalVnRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalVnRepo>(value),
    );
  }
}

String _$localVnRepoHash() => r'dd8b14ad372e062d9b64dcfa653176eac54af712';

@ProviderFor(getP1)
const getP1Provider = GetP1Family._();

final class GetP1Provider
    extends
        $FunctionalProvider<
          AsyncValue<VnDataPhase01?>,
          VnDataPhase01?,
          FutureOr<VnDataPhase01?>
        >
    with $FutureModifier<VnDataPhase01?>, $FutureProvider<VnDataPhase01?> {
  const GetP1Provider._({
    required GetP1Family super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getP1Provider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = localVnRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalVnRepoProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$getP1Hash();

  @override
  String toString() {
    return r'getP1Provider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VnDataPhase01?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VnDataPhase01?> create(Ref ref) {
    final argument = this.argument as String;
    return getP1(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetP1Provider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getP1Hash() => r'de7d94bfe96a05b23c662f98d6e0c36b6c6dfa34';

final class GetP1Family extends $Family
    with $FunctionalFamilyOverride<FutureOr<VnDataPhase01?>, String> {
  const GetP1Family._()
    : super(
        retry: null,
        name: r'getP1Provider',
        dependencies: const <ProviderOrFamily>[localVnRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          GetP1Provider.$allTransitiveDependencies0,
          GetP1Provider.$allTransitiveDependencies1,
        ],
        isAutoDispose: true,
      );

  GetP1Provider call(String vnId) =>
      GetP1Provider._(argument: vnId, from: this);

  @override
  String toString() => r'getP1Provider';
}

@ProviderFor(getP2)
const getP2Provider = GetP2Family._();

final class GetP2Provider
    extends
        $FunctionalProvider<
          AsyncValue<VnDataPhase02?>,
          VnDataPhase02?,
          FutureOr<VnDataPhase02?>
        >
    with $FutureModifier<VnDataPhase02?>, $FutureProvider<VnDataPhase02?> {
  const GetP2Provider._({
    required GetP2Family super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getP2Provider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = localVnRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalVnRepoProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$getP2Hash();

  @override
  String toString() {
    return r'getP2Provider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VnDataPhase02?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VnDataPhase02?> create(Ref ref) {
    final argument = this.argument as String;
    return getP2(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetP2Provider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getP2Hash() => r'07963dfa2534e40c2c6f9f04a4d21bedc51ab743';

final class GetP2Family extends $Family
    with $FunctionalFamilyOverride<FutureOr<VnDataPhase02?>, String> {
  const GetP2Family._()
    : super(
        retry: null,
        name: r'getP2Provider',
        dependencies: const <ProviderOrFamily>[localVnRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          GetP2Provider.$allTransitiveDependencies0,
          GetP2Provider.$allTransitiveDependencies1,
        ],
        isAutoDispose: true,
      );

  GetP2Provider call(String vnId) =>
      GetP2Provider._(argument: vnId, from: this);

  @override
  String toString() => r'getP2Provider';
}

@ProviderFor(getP3)
const getP3Provider = GetP3Family._();

final class GetP3Provider
    extends
        $FunctionalProvider<
          AsyncValue<VnDataPhase03?>,
          VnDataPhase03?,
          FutureOr<VnDataPhase03?>
        >
    with $FutureModifier<VnDataPhase03?>, $FutureProvider<VnDataPhase03?> {
  const GetP3Provider._({
    required GetP3Family super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'getP3Provider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = localVnRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalVnRepoProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$getP3Hash();

  @override
  String toString() {
    return r'getP3Provider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VnDataPhase03?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VnDataPhase03?> create(Ref ref) {
    final argument = this.argument as String;
    return getP3(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GetP3Provider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getP3Hash() => r'd7a0a434e248a14b561f07a8fb92adaaa35e4e45';

final class GetP3Family extends $Family
    with $FunctionalFamilyOverride<FutureOr<VnDataPhase03?>, String> {
  const GetP3Family._()
    : super(
        retry: null,
        name: r'getP3Provider',
        dependencies: const <ProviderOrFamily>[localVnRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          GetP3Provider.$allTransitiveDependencies0,
          GetP3Provider.$allTransitiveDependencies1,
        ],
        isAutoDispose: true,
      );

  GetP3Provider call(String vnId) =>
      GetP3Provider._(argument: vnId, from: this);

  @override
  String toString() => r'getP3Provider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
