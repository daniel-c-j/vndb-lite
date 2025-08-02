// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_appbar_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ShowSearchTextField)
const showSearchTextFieldProvider = ShowSearchTextFieldProvider._();

final class ShowSearchTextFieldProvider
    extends $NotifierProvider<ShowSearchTextField, bool> {
  const ShowSearchTextFieldProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'showSearchTextFieldProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$showSearchTextFieldHash();

  @$internal
  @override
  ShowSearchTextField create() => ShowSearchTextField();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$showSearchTextFieldHash() =>
    r'ac9e32098e7ed69bf81c66c17357ba54ea766c6c';

abstract class _$ShowSearchTextField extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
