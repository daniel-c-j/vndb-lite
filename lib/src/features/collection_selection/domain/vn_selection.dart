import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class VnSelection {
  VnSelection({
    required this.status,
    this.started,
    this.finished,
    required this.added,
    required this.vote,
    this.isNew = false,
  });

  final String status;
  final DateTime? started;
  final DateTime? finished;
  final DateTime added;
  final int vote;
  final bool isNew;

  VnSelection copyWith({
    String? status,
    DateTime? started,
    DateTime? finished,
    DateTime? added,
    int? vote,
    bool? isNew,
  }) {
    return VnSelection(
      status: status ?? this.status,
      started: started ?? this.started,
      finished: finished ?? this.finished,
      added: added ?? this.added,
      vote: vote ?? this.vote,
      isNew: isNew ?? this.isNew,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'started': started?.millisecondsSinceEpoch,
      'finished': finished?.millisecondsSinceEpoch,
      'added': added.millisecondsSinceEpoch,
      'vote': vote,
      'isNew': isNew,
    };
  }

  factory VnSelection.fromMap(Map<String, dynamic> map) {
    return VnSelection(
      status: map['status'] as String,
      started:
          map['started'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['started'] as int)
              : null,
      finished:
          map['finished'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['finished'] as int)
              : null,
      added: DateTime.fromMillisecondsSinceEpoch(map['added'] as int),
      vote: map['vote'] as int,
      isNew: map['isNew'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory VnSelection.fromJson(String source) =>
      VnSelection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VnSelection(status: $status, started: $started, finished: $finished, added: $added, vote: $vote, isNew: $isNew)';
  }

  @override
  bool operator ==(covariant VnSelection other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.started == started &&
        other.finished == finished &&
        other.added == added &&
        other.vote == vote &&
        other.isNew == isNew;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        started.hashCode ^
        finished.hashCode ^
        added.hashCode ^
        vote.hashCode ^
        isNew.hashCode;
  }
}
