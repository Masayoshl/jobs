// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Industry {
  int id;
  String title;
  Industry({
    required this.id,
    required this.title,
  });

  Industry copyWith({
    int? id,
    String? title,
  }) {
    return Industry(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory Industry.fromMap(Map<String, dynamic> map) {
    return Industry(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Industry.fromJson(String source) =>
      Industry.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'Industry(id: $id, title: $title)';

  @override
  bool operator ==(covariant Industry other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
