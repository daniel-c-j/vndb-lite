// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_selection_remote_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(fetchAndSaveP2Data)
const fetchAndSaveP2DataProvider = FetchAndSaveP2DataFamily._();

final class FetchAndSaveP2DataProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const FetchAndSaveP2DataProvider._({
    required FetchAndSaveP2DataFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchAndSaveP2DataProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  static const $allTransitiveDependencies0 = remoteVnRepoProvider;
  static const $allTransitiveDependencies1 =
      RemoteVnRepoProvider.$allTransitiveDependencies0;
  static const $allTransitiveDependencies2 =
      RemoteVnRepoProvider.$allTransitiveDependencies1;
  static const $allTransitiveDependencies3 = localVnRepoProvider;
  static const $allTransitiveDependencies4 =
      LocalVnRepoProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$fetchAndSaveP2DataHash();

  @override
  String toString() {
    return r'fetchAndSaveP2DataProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as String;
    return fetchAndSaveP2Data(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAndSaveP2DataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchAndSaveP2DataHash() =>
    r'119b5df20569d91cbe7fd6d7806d2b2f6820f16f';

final class FetchAndSaveP2DataFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, String> {
  const FetchAndSaveP2DataFamily._()
    : super(
        retry: null,
        name: r'fetchAndSaveP2DataProvider',
        dependencies: const <ProviderOrFamily>[
          remoteVnRepoProvider,
          localVnRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          FetchAndSaveP2DataProvider.$allTransitiveDependencies0,
          FetchAndSaveP2DataProvider.$allTransitiveDependencies1,
          FetchAndSaveP2DataProvider.$allTransitiveDependencies2,
          FetchAndSaveP2DataProvider.$allTransitiveDependencies3,
          FetchAndSaveP2DataProvider.$allTransitiveDependencies4,
        },
        isAutoDispose: true,
      );

  FetchAndSaveP2DataProvider call(String vnId) =>
      FetchAndSaveP2DataProvider._(argument: vnId, from: this);

  @override
  String toString() => r'fetchAndSaveP2DataProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
