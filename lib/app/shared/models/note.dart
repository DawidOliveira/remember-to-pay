import 'dart:convert';

class NoteModel {
  final String id;
  final String desc;
  final DateTime date;
  NoteModel({
    required this.id,
    required this.desc,
    required this.date,
  });

  NoteModel copyWith({
    String? id,
    String? desc,
    DateTime? date,
  }) {
    return NoteModel(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'desc': desc,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      desc: map['desc'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source));

  @override
  String toString() => 'NoteModel(id: $id, desc: $desc, date: $date)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteModel &&
        other.id == id &&
        other.desc == desc &&
        other.date == date;
  }

  @override
  int get hashCode => id.hashCode ^ desc.hashCode ^ date.hashCode;
}
