import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vn_item_grid_cover_censor_notifier.g.dart';

@riverpod
class VnItemGridCoverCensorNotifier extends _$VnItemGridCoverCensorNotifier {
  @override
  bool? build(String vnId) => null;

  void toggle() {
    if (state != null) state = !state!;
  }

  void set(bool value) => state = value;
}
