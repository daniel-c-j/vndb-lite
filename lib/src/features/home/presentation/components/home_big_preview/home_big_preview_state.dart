import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';

part 'home_big_preview_state.g.dart';

@Riverpod(keepAlive: true)
class CurrentHomeBigPreviewItemState extends _$CurrentHomeBigPreviewItemState {
  @override
  VnDataPhase01? build() => null;

  set item(VnDataPhase01 val) => state = val;
}

@riverpod
class HomeBigPreviewItemsState extends _$HomeBigPreviewItemsState {
  @override
  List<VnDataPhase01> build() => [];

  set items(List<VnDataPhase01> val) => state = val;
}
