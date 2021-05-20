import 'dart:convert';

class NoteModel {
  String id;
  String desc;
  DateTime date;
  bool synced;
  NoteModel({
    required this.id,
    required this.desc,
    required this.date,
    this.synced = false,
  });

  NoteModel copyWith({
    String? id,
    String? desc,
    DateTime? date,
    bool? synced,
  }) {
    return NoteModel(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      date: date ?? this.date,
      synced: synced ?? this.synced,
    );
  }

  void changeSynced(bool value) => this.synced = value;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'desc': desc,
      'date': date.millisecondsSinceEpoch,
      'synced': synced,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      desc: map['desc'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      synced: map['synced'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NoteModel(id: $id, desc: $desc, date: $date, synced: $synced)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteModel &&
        other.id == id &&
        other.desc == desc &&
        other.date == date &&
        other.synced == synced;
  }

  @override
  int get hashCode {
    return id.hashCode ^ desc.hashCode ^ date.hashCode ^ synced.hashCode;
  }
}
