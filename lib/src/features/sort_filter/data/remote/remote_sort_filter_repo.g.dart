// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_sort_filter_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(remoteSortFilterRepo)
const remoteSortFilterRepoProvider = RemoteSortFilterRepoProvider._();

final class RemoteSortFilterRepoProvider
    extends
        $FunctionalProvider<
          RemoteSortFilterRepo,
          RemoteSortFilterRepo,
          RemoteSortFilterRepo
        >
    with $Provider<RemoteSortFilterRepo> {
  const RemoteSortFilterRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteSortFilterRepoProvider',
        isAutoDispose: true,
        dependencies: const <ProviderOrFamily>[apiServiceProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          RemoteSortFilterRepoProvider.$allTransitiveDependencies0,
          RemoteSortFilterRepoProvider.$allTransitiveDependencies1,
        ],
      );

  static const $allTransitiveDependencies0 = apiServiceProvider;
  static const $allTransitiveDependencies1 =
      ApiServiceProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$remoteSortFilterRepoHash();

  @$internal
  @override
  $ProviderElement<RemoteSortFilterRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteSortFilterRepo create(Ref ref) {
    return remoteSortFilterRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteSortFilterRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteSortFilterRepo>(value),
    );
  }
}

String _$remoteSortFilterRepoHash() =>
    r'd6f634cb0cf05750f6954fb16fc46e3f0479a974';

@ProviderFor(fetchDevelopers)
const fetchDevelopersProvider = FetchDevelopersFamily._();

final class FetchDevelopersProvider
    extends
        $FunctionalProvider<AsyncValue<Response>, Response, FutureOr<Response>>
    with $FutureModifier<Response>, $FutureProvider<Response> {
  const FetchDevelopersProvider._({
    required FetchDevelopersFamily super.from,
    required (String, {CancelToken? cancelToken}) super.argument,
  }) : super(
         retry: null,
         name: r'fetchDevelopersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = remoteSortFilterRepoProvider;
  static const $allTransitiveDependencies1 =
      RemoteSortFilterRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RemoteSortFilterRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$fetchDevelopersHash();

  @override
  String toString() {
    return r'fetchDevelopersProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Response> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Response> create(Ref ref) {
    final argument = this.argument as (String, {CancelToken? cancelToken});
    return fetchDevelopers(ref, argument.$1, cancelToken: argument.cancelToken);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchDevelopersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchDevelopersHash() => r'3c3611993a8c20af457702485dba08a3ad59d7ef';

final class FetchDevelopersFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Response>,
          (String, {CancelToken? cancelToken})
        > {
  const FetchDevelopersFamily._()
    : super(
        retry: null,
        name: r'fetchDevelopersProvider',
        dependencies: const <ProviderOrFamily>[remoteSortFilterRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          FetchDevelopersProvider.$allTransitiveDependencies0,
          FetchDevelopersProvider.$allTransitiveDependencies1,
          FetchDevelopersProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: true,
      );

  FetchDevelopersProvider call(String devName, {CancelToken? cancelToken}) =>
      FetchDevelopersProvider._(
        argument: (devName, cancelToken: cancelToken),
        from: this,
      );

  @override
  String toString() => r'fetchDevelopersProvider';
}

@ProviderFor(fetchTags)
const fetchTagsProvider = FetchTagsFamily._();

final class FetchTagsProvider
    extends
        $FunctionalProvider<AsyncValue<Response>, Response, FutureOr<Response>>
    with $FutureModifier<Response>, $FutureProvider<Response> {
  const FetchTagsProvider._({
    required FetchTagsFamily super.from,
    required (String, {CancelToken? cancelToken}) super.argument,
  }) : super(
         retry: null,
         name: r'fetchTagsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = remoteSortFilterRepoProvider;
  static const $allTransitiveDependencies1 =
      RemoteSortFilterRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RemoteSortFilterRepoProvider.$allTransitiveDependencies1;

  @override
  String debugGetCreateSourceHash() => _$fetchTagsHash();

  @override
  String toString() {
    return r'fetchTagsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Response> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Response> create(Ref ref) {
    final argument = this.argument as (String, {CancelToken? cancelToken});
    return fetchTags(ref, argument.$1, cancelToken: argument.cancelToken);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchTagsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchTagsHash() => r'7956ea55a1ba8ceddea6a7664fd95f7e4de3fb15';

final class FetchTagsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Response>,
          (String, {CancelToken? cancelToken})
        > {
  const FetchTagsFamily._()
    : super(
        retry: null,
        name: r'fetchTagsProvider',
        dependencies: const <ProviderOrFamily>[remoteSortFilterRepoProvider],
        $allTransitiveDependencies: const <ProviderOrFamily>[
          FetchTagsProvider.$allTransitiveDependencies0,
          FetchTagsProvider.$allTransitiveDependencies1,
          FetchTagsProvider.$allTransitiveDependencies2,
        ],
        isAutoDispose: true,
      );

  FetchTagsProvider call(String tagName, {CancelToken? cancelToken}) =>
      FetchTagsProvider._(
        argument: (tagName, cancelToken: cancelToken),
        from: this,
      );

  @override
  String toString() => r'fetchTagsProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
