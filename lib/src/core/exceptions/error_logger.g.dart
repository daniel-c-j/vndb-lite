// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_logger.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Basic usage would be:
/// ```
/// try {}
/// catch (e, st) {
///    ref.read(errorLoggerProvider).logError(e, st);
/// }
/// ```
@ProviderFor(errorLogger)
const errorLoggerProvider = ErrorLoggerProvider._();

/// Basic usage would be:
/// ```
/// try {}
/// catch (e, st) {
///    ref.read(errorLoggerProvider).logError(e, st);
/// }
/// ```
final class ErrorLoggerProvider
    extends $FunctionalProvider<ErrorLogger, ErrorLogger, ErrorLogger>
    with $Provider<ErrorLogger> {
  /// Basic usage would be:
  /// ```
  /// try {}
  /// catch (e, st) {
  ///    ref.read(errorLoggerProvider).logError(e, st);
  /// }
  /// ```
  const ErrorLoggerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'errorLoggerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$errorLoggerHash();

  @$internal
  @override
  $ProviderElement<ErrorLogger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ErrorLogger create(Ref ref) {
    return errorLogger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ErrorLogger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ErrorLogger>(value),
    );
  }
}

String _$errorLoggerHash() => r'6015cbbe9f8999e8b299acf81516571f33272627';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
