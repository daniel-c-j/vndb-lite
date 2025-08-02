// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notification_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(localNotifService)
const localNotifServiceProvider = LocalNotifServiceProvider._();

final class LocalNotifServiceProvider
    extends
        $FunctionalProvider<
          LocalNotificationService,
          LocalNotificationService,
          LocalNotificationService
        >
    with $Provider<LocalNotificationService> {
  const LocalNotifServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotifServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotifServiceHash();

  @$internal
  @override
  $ProviderElement<LocalNotificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalNotificationService create(Ref ref) {
    return localNotifService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotificationService>(value),
    );
  }
}

String _$localNotifServiceHash() => r'529d0d6af2bf6fa33c5d5310318edf57e670cd04';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
