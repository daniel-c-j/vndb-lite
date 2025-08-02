// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_vn_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(validateVnAndSaveToLocal)
const validateVnAndSaveToLocalProvider = ValidateVnAndSaveToLocalFamily._();

final class ValidateVnAndSaveToLocalProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const ValidateVnAndSaveToLocalProvider._({
    required ValidateVnAndSaveToLocalFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'validateVnAndSaveToLocalProvider',
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
  String debugGetCreateSourceHash() => _$validateVnAndSaveToLocalHash();

  @override
  String toString() {
    return r'validateVnAndSaveToLocalProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return validateVnAndSaveToLocal(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ValidateVnAndSaveToLocalProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$validateVnAndSaveToLocalHash() =>
    r'35bf1c70e4dcd4908a8652268297bb579efed696';

final class ValidateVnAndSaveToLocalFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  const ValidateVnAndSaveToLocalFamily._()
    : super(
        retry: null,
        name: r'validateVnAndSaveToLocalProvider',
        dependencies: const <ProviderOrFamily>[
          remoteVnRepoProvider,
          localVnRepoProvider,
        ],
        $allTransitiveDependencies: const <ProviderOrFamily>{
          ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies0,
          ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies1,
          ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies2,
          ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies3,
          ValidateVnAndSaveToLocalProvider.$allTransitiveDependencies4,
        },
        isAutoDispose: true,
      );

  ValidateVnAndSaveToLocalProvider call(String vnId) =>
      ValidateVnAndSaveToLocalProvider._(argument: vnId, from: this);

  @override
  String toString() => r'validateVnAndSaveToLocalProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
