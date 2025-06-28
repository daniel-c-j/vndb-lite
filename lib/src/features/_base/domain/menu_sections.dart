// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class MenuSections {
  const MenuSections({required this.title, required this.nonActiveIcon, required this.activeIcon});

  final String title;
  final IconData nonActiveIcon;
  final IconData activeIcon;

  MenuSections copyWith({String? title, IconData? nonActiveIcon, IconData? activeIcon}) {
    return MenuSections(
      title: title ?? this.title,
      nonActiveIcon: nonActiveIcon ?? this.nonActiveIcon,
      activeIcon: activeIcon ?? this.activeIcon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'nonActiveIcon': nonActiveIcon.codePoint,
      'activeIcon': activeIcon.codePoint,
    };
  }

  factory MenuSections.fromMap(Map<String, dynamic> map) {
    return MenuSections(
      title: map['title'] as String,
      nonActiveIcon: IconData(map['nonActiveIcon'] as int, fontFamily: 'MaterialIcons'),
      activeIcon: IconData(map['activeIcon'] as int, fontFamily: 'MaterialIcons'),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuSections.fromJson(String source) =>
      MenuSections.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MenuSections(title: $title, nonActiveIcon: $nonActiveIcon, activeIcon: $activeIcon)';

  @override
  bool operator ==(covariant MenuSections other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.nonActiveIcon == nonActiveIcon &&
        other.activeIcon == activeIcon;
  }

  @override
  int get hashCode => title.hashCode ^ nonActiveIcon.hashCode ^ activeIcon.hashCode;
}
