// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localFilterService)
const localFilterServiceProvider = LocalFilterServiceProvider._();

final class LocalFilterServiceProvider
    extends
        $FunctionalProvider<
          LocalFilterService,
          LocalFilterService,
          LocalFilterService
        >
    with $Provider<LocalFilterService> {
  const LocalFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localFilterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localFilterServiceHash();

  @$internal
  @override
  $ProviderElement<LocalFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalFilterService create(Ref ref) {
    return localFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalFilterService>(value),
    );
  }
}

String _$localFilterServiceHash() =>
    r'd241185024fad686379b71f20b99e1028ff13881';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
