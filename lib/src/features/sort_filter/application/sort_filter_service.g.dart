// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_filter_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(sortFilterService)
const sortFilterServiceProvider = SortFilterServiceProvider._();

final class SortFilterServiceProvider
    extends
        $FunctionalProvider<
          SortFilterService,
          SortFilterService,
          SortFilterService
        >
    with $Provider<SortFilterService> {
  const SortFilterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortFilterServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortFilterServiceHash();

  @$internal
  @override
  $ProviderElement<SortFilterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SortFilterService create(Ref ref) {
    return sortFilterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SortFilterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SortFilterService>(value),
    );
  }
}

String _$sortFilterServiceHash() => r'e0a83d37d4c045ccff8f80ad6212658b908658b4';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
