import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_progress_indicator_state.g.dart';

@riverpod
class BottomProgressIndicator extends _$BottomProgressIndicator {
  @override
  bool build() => false;
  set show(bool value) => state = value;
}
