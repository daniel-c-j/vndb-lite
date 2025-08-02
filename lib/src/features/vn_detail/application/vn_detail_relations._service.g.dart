// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vn_detail_relations._service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(fetchAndSaveP3Data)
const fetchAndSaveP3DataProvider = FetchAndSaveP3DataFamily._();

final class FetchAndSaveP3DataProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const FetchAndSaveP3DataProvider._({
    required FetchAndSaveP3DataFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchAndSaveP3DataProvider',
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
  String debugGetCreateSourceHash() => _$fetchAndSaveP3DataHash();

  @override
  String toString() {
    return r'fetchAndSaveP3DataProvider'
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
    return fetchAndSaveP3Data(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAndSaveP3DataProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchAndSaveP3DataHash() =>
    r'341f907abf72de6a564f67fd41d43ac52b5f2999';

final class FetchAndSaveP3DataFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, String> {
  const FetchAndSaveP3DataFamily._()
    : super(
        retry: null,
        name: r'fetchAndSaveP3DataProvider',
        dependencies: const <ProviderOrFamily>[
          remoteVnRepoProvider,
          localVnRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          FetchAndSaveP3DataProvider.$allTransitiveDependencies0,
          FetchAndSaveP3DataProvider.$allTransitiveDependencies1,
          FetchAndSaveP3DataProvider.$allTransitiveDependencies2,
          FetchAndSaveP3DataProvider.$allTransitiveDependencies3,
          FetchAndSaveP3DataProvider.$allTransitiveDependencies4,
        },
        isAutoDispose: true,
      );

  FetchAndSaveP3DataProvider call(String vnId) =>
      FetchAndSaveP3DataProvider._(argument: vnId, from: this);

  @override
  String toString() => r'fetchAndSaveP3DataProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
