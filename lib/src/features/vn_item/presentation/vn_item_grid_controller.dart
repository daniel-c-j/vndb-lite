import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vn_item_grid_controller.g.dart';

@Riverpod(keepAlive: true)
class VnItemGridCoverCensorState extends _$VnItemGridCoverCensorState {
  @override
  bool build(String vnId) => false;
  set censor(bool value) => state = value;
}

@riverpod
class VnItemGridAlmostLongPressedState extends _$VnItemGridAlmostLongPressedState {
  @override
  String build() {
    return "";
  }

  set vnId(String value) => state = value;
}
