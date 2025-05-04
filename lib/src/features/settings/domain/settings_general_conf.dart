// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:vndb_lite/src/features/home/data/preview_sections_data.dart';

class SettingsGeneralConf {
  const SettingsGeneralConf({
    required this.showCoverCensor,
    required this.showChart,
    required this.maxPreviewItem,
    required this.maxItemPerRowPortrait,
    required this.maxItemPerRowLandscape,
    required this.homeSectionsArrangement,
    required this.collectionStatusTabArrangement,
  });

  final bool showCoverCensor;
  final bool showChart;
  final int maxPreviewItem;
  final int maxItemPerRowPortrait;
  final int maxItemPerRowLandscape;
  final List<HomeSectionsCode> homeSectionsArrangement;
  final List<String> collectionStatusTabArrangement;

  SettingsGeneralConf copyWith({
    bool? showCoverCensor,
    bool? showChart,
    int? maxPreviewItem,
    int? maxItemPerRowPortrait,
    int? maxItemPerRowLandscape,
    List<HomeSectionsCode>? homeSectionsArrangement,
    List<String>? collectionStatusTabArrangement,
  }) {
    return SettingsGeneralConf(
      showCoverCensor: showCoverCensor ?? this.showCoverCensor,
      showChart: showChart ?? this.showChart,
      maxPreviewItem: maxPreviewItem ?? this.maxPreviewItem,
      maxItemPerRowPortrait: maxItemPerRowPortrait ?? this.maxItemPerRowPortrait,
      maxItemPerRowLandscape: maxItemPerRowLandscape ?? this.maxItemPerRowLandscape,
      homeSectionsArrangement: homeSectionsArrangement ?? this.homeSectionsArrangement,
      collectionStatusTabArrangement:
          collectionStatusTabArrangement ?? this.collectionStatusTabArrangement,
    );
  }

  @override
  String toString() {
    return 'SettingsGeneralConf(showCoverCensor: $showCoverCensor, showChart: $showChart, maxPreviewItem: $maxPreviewItem, maxItemPerRowPortrait: $maxItemPerRowPortrait, maxItemPerRowLandscape: $maxItemPerRowLandscape, homeSectionsArrangement: $homeSectionsArrangement, collectionStatusTabArrangement: $collectionStatusTabArrangement)';
  }

  @override
  bool operator ==(covariant SettingsGeneralConf other) {
    if (identical(this, other)) return true;

    return other.showCoverCensor == showCoverCensor &&
        other.showChart == showChart &&
        other.maxPreviewItem == maxPreviewItem &&
        other.maxItemPerRowPortrait == maxItemPerRowPortrait &&
        other.maxItemPerRowLandscape == maxItemPerRowLandscape &&
        listEquals(other.homeSectionsArrangement, homeSectionsArrangement) &&
        listEquals(other.collectionStatusTabArrangement, collectionStatusTabArrangement);
  }

  @override
  int get hashCode {
    return showCoverCensor.hashCode ^
        showChart.hashCode ^
        maxPreviewItem.hashCode ^
        maxItemPerRowPortrait.hashCode ^
        maxItemPerRowLandscape.hashCode ^
        homeSectionsArrangement.hashCode ^
        collectionStatusTabArrangement.hashCode;
  }
}
