// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_chart_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SearchChartSpinController)
const searchChartSpinControllerProvider = SearchChartSpinControllerProvider._();

final class SearchChartSpinControllerProvider
    extends $NotifierProvider<SearchChartSpinController, double> {
  const SearchChartSpinControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchChartSpinControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchChartSpinControllerHash();

  @$internal
  @override
  SearchChartSpinController create() => SearchChartSpinController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$searchChartSpinControllerHash() =>
    r'fd8011c7e4d0fd8eab454237937a7c57eee49212';

abstract class _$SearchChartSpinController extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
