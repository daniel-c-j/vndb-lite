import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/features/collection/data/local/local_collection_repo.dart';
import 'package:vndb_lite/src/features/collection/domain/record.dart';
import 'package:vndb_lite/src/util/debouncer.dart';

part 'vn_record_controller.g.dart';

@Riverpod(keepAlive: true, dependencies: [localCollectionRepo])
class VnRecordController extends _$VnRecordController {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 400));

  @override
  VnRecord? build(String vnId) {
    _getRecord();
    return null;
  }

  void _getRecord() {
    _debouncer.call(() {
      state = ref.watch(localCollectionRepoProvider).getVnRecordFromId(vnId);
    });
  }

  void refresh() {
    if (state != null) state = state!.copyWith();
  }

  void importRecord(VnRecord? record) => state = record;
}
