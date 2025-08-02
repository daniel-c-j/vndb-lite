// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_error_handler_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(netErrorHandler)
const netErrorHandlerProvider = NetErrorHandlerProvider._();

final class NetErrorHandlerProvider
    extends
        $FunctionalProvider<
          NetworkErrorHandlerService,
          NetworkErrorHandlerService,
          NetworkErrorHandlerService
        >
    with $Provider<NetworkErrorHandlerService> {
  const NetErrorHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'netErrorHandlerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$netErrorHandlerHash();

  @$internal
  @override
  $ProviderElement<NetworkErrorHandlerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NetworkErrorHandlerService create(Ref ref) {
    return netErrorHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkErrorHandlerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkErrorHandlerService>(value),
    );
  }
}

String _$netErrorHandlerHash() => r'64aa4826e1c6d23cb37d975ff3442c05ed9327dc';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
