import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';
import 'package:vndb_lite/src/common_widgets/generic_shadowy_text.dart';
import 'package:vndb_lite/src/common_widgets/masonry_grid.dart';
import 'package:vndb_lite/src/util/delay.dart';
import 'package:vndb_lite/src/util/responsive.dart';
import 'package:vndb_lite/src/features/settings/presentation/settings_general_state.dart';
import 'package:vndb_lite/src/features/vn/data/local_vn_repo.dart';
import 'package:vndb_lite/src/features/vn/domain/others.dart';
import 'package:vndb_lite/src/features/vn/domain/p3.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';
import 'package:vndb_lite/src/features/vn_item/presentation/vn_item_grid_.dart';

class VnDetailRelationsRelation extends ConsumerStatefulWidget {
  const VnDetailRelationsRelation({super.key, required this.p3});

  final VnDataPhase03 p3;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VnDetailRelationsRelationState();
}

class _VnDetailRelationsRelationState extends ConsumerState<VnDetailRelationsRelation> {
  bool _onlyOfficial = true;

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  bool get _isThereRelation {
    return widget.p3.relations != null || widget.p3.relations!.isNotEmpty;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Future<List<Widget>> get _relationsList async {
    if (!_isThereRelation) return [];
    await delay(true, 1000);

    final List<VnItemGrid> relationWidget = [];
    final localVnRepo = ref.watch(localVnRepoProvider);

    for (VnRelation relation in _arrangedRelations) {
      // Safeguard
      if (relation.id == null || relation.relation == null) continue;

      final p1 = await localVnRepo.getP1(relation.id!);
      if (p1 == null) continue;

      relationWidget.add(
        VnItemGrid(key: UniqueKey(), p1: p1, labelCode: relation.relation!, isGridView: true),
      );
    }

    return relationWidget;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  // Sorting utilities

  bool _isOfficial(VnRelation relation) {
    return relation.relation_official ?? false;
  }

  bool _isHighPriority(VnRelation relation) {
    if (relation.relation == 'seq' || relation.relation == 'preq' || relation.relation == 'orig') {
      return true;
    }

    return false;
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  List<VnRelation> get _arrangedRelations {
    final List<VnRelation> lowPriorityRelations = [];
    final List<VnRelation> highPriorityRelations = [];

    for (VnRelation relation in (widget.p3.relations ?? [])) {
      // An optimization, whether to include non-official relation or not. Comment the line below to
      // allow non-official relation to be rendered in the UI.
      if (_onlyOfficial) if (!_isOfficial(relation)) continue;

      if (_isHighPriority(relation)) {
        highPriorityRelations.add(relation);
        continue;
      }

      lowPriorityRelations.add(relation);
    }

    // High priority goes first.
    return [...highPriorityRelations, ...lowPriorityRelations];
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  Widget _relationOfficialSwitchButton({required Color color, required String title}) {
    return CustomButton(
      margin: EdgeInsets.symmetric(horizontal: responsiveUI.own(0.01)),
      onTap: () {
        setState(() {
          _onlyOfficial = !_onlyOfficial;
        });
      },
      padding: EdgeInsets.symmetric(horizontal: responsiveUI.own(0.025)),
      buttonColor: (_onlyOfficial) ? color : Colors.grey,
      child: ShadowText(title),
    );
  }

  //
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsGeneralStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadowText(
          'Related/Similar VNs',
          fontSize: responsiveUI.own(0.045),
          fontWeight: FontWeight.bold,
        ),
        Wrap(
          children: [
            ShadowText('Relation: '),
            _relationOfficialSwitchButton(
              color: kColor(context).secondary.withOpacity(0.7),
              title: "Official-only",
            ),
          ],
        ),
        SizedBox(height: responsiveUI.own(0.025)),
        FutureBuilder(
          future: _relationsList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.all(responsiveUI.own(0.1)),
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            final relations = snapshot.data;
            if (relations.isEmpty) return ShadowText('--');

            return MasonryGridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).orientation == Orientation.portrait)
                        ? settings.maxItemPerRowPortrait
                        : settings.maxItemPerRowLandscape,
              ),
              mainAxisSpacing: responsiveUI.own(0.03),
              itemCount: relations.length,
              itemBuilder: (context, index) {
                return relations[index];
              },
            );
          },
        ),
      ],
    );
  }
}
