import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/features/collection/data/local/local_collection_repo.dart';
import 'package:vndb_lite/src/features/collection/domain/record.dart';

part 'vn_record_state.g.dart';

final Map<String, VnRecord?> cachedRecord = {};

@Riverpod(dependencies: [localCollectionRepo])
class VnRecordState extends _$VnRecordState {
  @override
  VnRecord? build(String vnId) {
    return cachedRecord[vnId] ?? ref.watch(localCollectionRepoProvider).getVnRecordFromId(vnId);
  }

  void refresh() {
    if (state != null) state = state!.copyWith();
  }

  void importRecord(VnRecord? record) => state = record;
}
