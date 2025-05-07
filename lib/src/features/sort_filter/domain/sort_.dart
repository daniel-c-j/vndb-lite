// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SortData {
  const SortData({this.reverse = true, this.sort = "searchrank"});

  final bool? reverse;
  final String? sort;

  SortData copyWith({bool? reverse, String? sort}) {
    return SortData(reverse: reverse ?? this.reverse, sort: sort ?? this.sort);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'reverse': reverse, if (sort != null) 'sort': sort};
  }

  factory SortData.fromMap(Map<String, dynamic> map) {
    return SortData(
      reverse: map['reverse'] != null ? map['reverse'] as bool : null,
      sort: map['sort'] != null ? map['sort'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SortData.fromJson(String source) =>
      SortData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SortData(reverse: $reverse, sort: $sort)';

  @override
  bool operator ==(covariant SortData other) {
    if (identical(this, other)) return true;

    return other.reverse == reverse && other.sort == sort;
  }

  @override
  int get hashCode => reverse.hashCode ^ sort.hashCode;
}
