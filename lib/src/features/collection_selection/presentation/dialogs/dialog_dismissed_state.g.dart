// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_dismissed_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(DialogDismissedState)
const dialogDismissedStateProvider = DialogDismissedStateProvider._();

final class DialogDismissedStateProvider
    extends $NotifierProvider<DialogDismissedState, bool> {
  const DialogDismissedStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dialogDismissedStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dialogDismissedStateHash();

  @$internal
  @override
  DialogDismissedState create() => DialogDismissedState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$dialogDismissedStateHash() =>
    r'c59834eb45365e3c7dfe0e1403a41a962f0c12f5';

abstract class _$DialogDismissedState extends $Notifier<bool> {
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
