// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VnRecord {
  const VnRecord({
    required this.id,
    required this.title,
    required this.status,
    required this.vote,
    this.added,
    this.started,
    this.finished,
    this.lastmod,
    this.notes,
  });

  final String id;
  final String title;
  final String status;
  final int vote;
  final String? added;
  final String? started;
  final String? finished;
  final String? lastmod;
  final String? notes;

  VnRecord copyWith({
    String? id,
    String? title,
    String? status,
    int? vote,
    String? added,
    String? started,
    String? finished,
    String? lastmod,
    String? notes,
  }) {
    return VnRecord(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      vote: vote ?? this.vote,
      added: added ?? this.added,
      started: started ?? this.started,
      finished: finished ?? this.finished,
      lastmod: lastmod ?? this.lastmod,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'status': status,
      'vote': vote,
      'added': added,
      'started': started,
      'finished': finished,
      'lastmod': lastmod,
      'notes': notes,
    };
  }

  factory VnRecord.fromMap(Map<String, dynamic> map) {
    return VnRecord(
      id: map['id'] as String,
      title: map['title'] as String,
      status: map['status'] as String,
      vote: map['vote'] as int,
      added: map['added'] != null ? map['added'] as String : null,
      started: map['started'] != null ? map['started'] as String : null,
      finished: map['finished'] != null ? map['finished'] as String : null,
      lastmod: map['lastmod'] != null ? map['lastmod'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VnRecord.fromJson(String source) =>
      VnRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VnRecord(id: $id, title: $title, status: $status, vote: $vote, added: $added, started: $started, finished: $finished, lastmod: $lastmod, notes: $notes)';
  }

  @override
  bool operator ==(covariant VnRecord other) {
    if (identical(this, other)) return true;
    return other.id == id && other.lastmod == lastmod;
  }

  @override
  int get hashCode {
    return id.hashCode ^ lastmod.hashCode;
  }
}
