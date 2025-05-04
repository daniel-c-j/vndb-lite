// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:vndb_lite/src/features/sort_filter/data/sortable_data.dart';
import 'package:vndb_lite/src/features/sort_filter/domain/filter_.dart';

class HomePreviewSection {
  const HomePreviewSection({
    required this.title,
    required this.id,
    this.labelCode,
    this.filter,
    required this.maxPreviewItem,
  });

  final String title;
  final int id;
  final SortableCode? labelCode;
  final FilterData? filter;
  final int maxPreviewItem;

  @override
  bool operator ==(covariant HomePreviewSection other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.id == id &&
        other.labelCode == labelCode &&
        other.filter == filter &&
        other.maxPreviewItem == maxPreviewItem;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        labelCode.hashCode ^
        filter.hashCode ^
        maxPreviewItem.hashCode;
  }

  HomePreviewSection copyWith({
    String? title,
    int? id,
    SortableCode? labelCode,
    FilterData? filter,
    int? maxPreviewItem,
  }) {
    return HomePreviewSection(
      title: title ?? this.title,
      id: id ?? this.id,
      labelCode: labelCode ?? this.labelCode,
      filter: filter ?? this.filter,
      maxPreviewItem: maxPreviewItem ?? this.maxPreviewItem,
    );
  }
}
