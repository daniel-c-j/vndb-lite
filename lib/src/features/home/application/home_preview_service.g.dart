// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_preview_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(homePreviewService)
const homePreviewServiceProvider = HomePreviewServiceProvider._();

final class HomePreviewServiceProvider
    extends
        $FunctionalProvider<
          HomePreviewService,
          HomePreviewService,
          HomePreviewService
        >
    with $Provider<HomePreviewService> {
  const HomePreviewServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homePreviewServiceProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[
          localHomeRepoProvider,
          remoteHomeRepoProvider,
          localVnRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          HomePreviewServiceProvider.$allTransitiveDependencies0,
          HomePreviewServiceProvider.$allTransitiveDependencies1,
          HomePreviewServiceProvider.$allTransitiveDependencies2,
          HomePreviewServiceProvider.$allTransitiveDependencies3,
          HomePreviewServiceProvider.$allTransitiveDependencies4,
          HomePreviewServiceProvider.$allTransitiveDependencies5,
        },
      );

  static const $allTransitiveDependencies0 = localHomeRepoProvider;
  static const $allTransitiveDependencies1 =
      LocalHomeRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 = remoteHomeRepoProvider;
  static const $allTransitiveDependencies3 =
      RemoteHomeRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies4 =
      RemoteHomeRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies5 =
      RemoteHomeRepoProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$homePreviewServiceHash();

  @$internal
  @override
  $ProviderElement<HomePreviewService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomePreviewService create(Ref ref) {
    return homePreviewService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomePreviewService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomePreviewService>(value),
    );
  }
}

String _$homePreviewServiceHash() =>
    r'5730a9af91f824e8dcd2562f7ab0a47ad4dd47f4';

@ProviderFor(getPreviewData)
const getPreviewDataProvider = GetPreviewDataFamily._();

final class GetPreviewDataProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, FutureOr<dynamic>>
    with $FutureModifier<dynamic>, $FutureProvider<dynamic> {
  const GetPreviewDataProvider._({
    required GetPreviewDataFamily super.from,
    required ({
      HomeSectionsCode sectionData,
      String cacheKey,
      int maxItem,
      CancelToken? cancelToken,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'getPreviewDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = homePreviewServiceProvider;
  static const $allTransitiveDependencies1 =
      HomePreviewServiceProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      HomePreviewServiceProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      HomePreviewServiceProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      HomePreviewServiceProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      HomePreviewServiceProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies6 =
      HomePreviewServiceProvider.$allTransitiveDependencies5;

  @override
  String debugGetCreateSourceHash() => _$getPreviewDataHash();

  @override
  String toString() {
    return r'getPreviewDataProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<dynamic> create(Ref ref) {
    final argument =
        this.argument
            as ({
              HomeSectionsCode sectionData,
              String cacheKey,
              int maxItem,
              CancelToken? cancelToken,
            });
    return getPreviewData(
      ref,
      sectionData: argument.sectionData,
      cacheKey: argument.cacheKey,
      maxItem: argument.maxItem,
      cancelToken: argument.cancelToken,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GetPreviewDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$getPreviewDataHash() => r'577d54aa734392466eeb7c63d3fdfa7a3c5cbbd4';

final class GetPreviewDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<dynamic>,
          ({
            HomeSectionsCode sectionData,
            String cacheKey,
            int maxItem,
            CancelToken? cancelToken,
          })
        > {
  const GetPreviewDataFamily._()
    : super(
        retry: null,
        name: r'getPreviewDataProvider',
        dependencies: const <ProviderOrFamily>[homePreviewServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          GetPreviewDataProvider.$allTransitiveDependencies0,
          GetPreviewDataProvider.$allTransitiveDependencies1,
          GetPreviewDataProvider.$allTransitiveDependencies2,
          GetPreviewDataProvider.$allTransitiveDependencies3,
          GetPreviewDataProvider.$allTransitiveDependencies4,
          GetPreviewDataProvider.$allTransitiveDependencies5,
          GetPreviewDataProvider.$allTransitiveDependencies6,
        },
        isAutoDispose: true,
      );

  GetPreviewDataProvider call({
    required HomeSectionsCode sectionData,
    required String cacheKey,
    required int maxItem,
    CancelToken? cancelToken,
  }) => GetPreviewDataProvider._(
    argument: (
      sectionData: sectionData,
      cacheKey: cacheKey,
      maxItem: maxItem,
      cancelToken: cancelToken,
    ),
    from: this,
  );

  @override
  String toString() => r'getPreviewDataProvider';
}

@ProviderFor(formatPreviewData)
const formatPreviewDataProvider = FormatPreviewDataFamily._();

final class FormatPreviewDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<VnDataPhase01>>,
          List<VnDataPhase01>,
          FutureOr<List<VnDataPhase01>>
        >
    with
        $FutureModifier<List<VnDataPhase01>>,
        $FutureProvider<List<VnDataPhase01>> {
  const FormatPreviewDataProvider._({
    required FormatPreviewDataFamily super.from,
    required (dynamic, {String cacheKey}) super.argument,
  }) : super(
         retry: null,
         name: r'formatPreviewDataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = homePreviewServiceProvider;
  static const $allTransitiveDependencies1 =
      HomePreviewServiceProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      HomePreviewServiceProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 =
      HomePreviewServiceProvider.$allTransitiveDependencies2;
  static const $allTransitiveDependencies4 =
      HomePreviewServiceProvider.$allTransitiveDependencies3;
  static const $allTransitiveDependencies5 =
      HomePreviewServiceProvider.$allTransitiveDependencies4;
  static const $allTransitiveDependencies6 =
      HomePreviewServiceProvider.$allTransitiveDependencies5;

  @override
  String debugGetCreateSourceHash() => _$formatPreviewDataHash();

  @override
  String toString() {
    return r'formatPreviewDataProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<VnDataPhase01>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<VnDataPhase01>> create(Ref ref) {
    final argument = this.argument as (dynamic, {String cacheKey});
    return formatPreviewData(ref, argument.$1, cacheKey: argument.cacheKey);
  }

  @override
  bool operator ==(Object other) {
    return other is FormatPreviewDataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$formatPreviewDataHash() => r'5c2e6f6c1161cf6b12ca087d457ca0154f0f7867';

final class FormatPreviewDataFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<VnDataPhase01>>,
          (dynamic, {String cacheKey})
        > {
  const FormatPreviewDataFamily._()
    : super(
        retry: null,
        name: r'formatPreviewDataProvider',
        dependencies: const <ProviderOrFamily>[homePreviewServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          FormatPreviewDataProvider.$allTransitiveDependencies0,
          FormatPreviewDataProvider.$allTransitiveDependencies1,
          FormatPreviewDataProvider.$allTransitiveDependencies2,
          FormatPreviewDataProvider.$allTransitiveDependencies3,
          FormatPreviewDataProvider.$allTransitiveDependencies4,
          FormatPreviewDataProvider.$allTransitiveDependencies5,
          FormatPreviewDataProvider.$allTransitiveDependencies6,
        },
        isAutoDispose: true,
      );

  FormatPreviewDataProvider call(dynamic rawData, {required String cacheKey}) =>
      FormatPreviewDataProvider._(
        argument: (rawData, cacheKey: cacheKey),
        from: this,
      );

  @override
  String toString() => r'formatPreviewDataProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
