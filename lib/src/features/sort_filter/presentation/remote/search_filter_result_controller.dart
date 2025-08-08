import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_filter_result_controller.g.dart';

@riverpod
class DevSearchState extends _$DevSearchState {
  @override
  String build() {
    return "";
  }

  @override
  set state(String newState) => super.state = newState;
}

@riverpod
class TagSearchState extends _$TagSearchState {
  @override
  String build() {
    return "";
  }

  @override
  set state(String newState) => super.state = newState;
}
