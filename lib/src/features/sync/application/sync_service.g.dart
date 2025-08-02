// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(syncService)
const syncServiceProvider = SyncServiceFamily._();

final class SyncServiceProvider
    extends $FunctionalProvider<SyncService, SyncService, SyncService>
    with $Provider<SyncService> {
  const SyncServiceProvider._({
    required SyncServiceFamily super.from,
    required void Function(
      String, {
      required IconData icon,
      required Color iconColor,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'syncServiceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$syncServiceHash();

  @override
  String toString() {
    return r'syncServiceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<SyncService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncService create(Ref ref) {
    final argument =
        this.argument
            as void Function(
              String, {
              required IconData icon,
              required Color iconColor,
            });
    return syncService(ref, snackbar: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncService>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SyncServiceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$syncServiceHash() => r'99fb48aa249169a7302c0af8d5e607b5b0e4db39';

final class SyncServiceFamily extends $Family
    with
        $FunctionalFamilyOverride<
          SyncService,
          void Function(
            String, {
            required IconData icon,
            required Color iconColor,
          })
        > {
  const SyncServiceFamily._()
    : super(
        retry: null,
        name: r'syncServiceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SyncServiceProvider call({
    required void Function(
      String, {
      required IconData icon,
      required Color iconColor,
    })
    snackbar,
  }) => SyncServiceProvider._(argument: snackbar, from: this);

  @override
  String toString() => r'syncServiceProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
