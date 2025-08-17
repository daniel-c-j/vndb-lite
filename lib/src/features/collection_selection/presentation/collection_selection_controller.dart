// ignore_for_file: avoid_public_notifier_properties
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/features/collection/data/collection_status_data.dart';
import 'package:vndb_lite/src/features/collection/domain/record.dart';
import 'package:vndb_lite/src/features/collection_selection/application/collection_selection_service.dart';
import 'package:vndb_lite/src/features/collection_selection/domain/vn_selection.dart';
import 'package:vndb_lite/src/features/collection_selection/presentation/multiselection/record_selected_controller.dart';
import 'package:vndb_lite/src/features/vn/domain/p1.dart';

part 'collection_selection_controller.g.dart';

// Processing selection.
@Riverpod(dependencies: [vnSelectionService])
class VnSelectionController extends _$VnSelectionController {
  final Map<String, VnRecord?> _vnRecords = {};

  @override
  VnSelection build() {
    ref.onDispose(() => _vnRecords.clear());
    return VnSelection(status: CollectionStatusCode.playing.name, added: DateTime.now(), vote: 0);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Map<String, VnRecord?> get records => _vnRecords;

  void copyWith({
    DateTime? started,
    DateTime? finished,
    DateTime? added,
    String? status,
    int? vote,
    bool? isNew,
  }) {
    state = VnSelection(
      started: started ?? state.started,
      finished: finished ?? state.finished,
      added: added ?? state.added,
      status: status ?? state.status,
      vote: vote ?? state.vote,
      isNew: isNew ?? state.isNew,
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  /// Converts p1 to record.
  void init(List<VnDataPhase01> p1s) {
    _vnRecords.addAll(ref.read(vnSelectionServiceProvider).getVnRecords(p1s));

    // If it's individual, by default will show the latest values.
    // Do not use !isMultiselection, it will not initialized yet (since this is an init method)
    if (_vnRecords.length == 1) {
      final vnRecord = _vnRecords.values.first;

      if (vnRecord != null) {
        final newState = state.copyWith(
          started: DateTime.tryParse(vnRecord.started!),
          finished: DateTime.tryParse(vnRecord.finished!),
          status: vnRecord.status,
          vote: vnRecord.vote,
        );

        state = newState;
        return;
      }

      // ? VnRecord does not exists, that means that its new.
      state = state.copyWith(isNew: true);
      return;
    }

    // Default value changed to special mixed value if in multimode. The rest will
    // be null or dependent on each item's latest record.
    state = state.copyWith(vote: -1, status: 'Mixed', started: null, finished: null);
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  void setToMultiselection(List<String> recordSelected, List<VnDataPhase01> p1List) {
    for (VnDataPhase01 p1 in p1List) {
      if (recordSelected.contains(p1.id)) continue;
      recordSelected.add(p1.id);
    }
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<void> remove({
    required VoidCallback whenSuccess,
    required void Function(String) removeRefresh,
  }) async {
    final selectionService = ref.read(vnSelectionServiceProvider);
    await selectionService.removeSelection(
      _vnRecords.values.toList(),
      whenSuccess: whenSuccess,
      removeRefresh: removeRefresh,
    );

    _vnRecords.clear();
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //
}
