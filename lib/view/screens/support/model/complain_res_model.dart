import 'dart:convert';
class ComplainResModel {
  String id;
  String title;
  String body;
  ComplainResModel({
    required this.id,
    required this.title,
    required this.body,
  });

  // {
  //         "id": "d8d4fb63-085c-41e2-8540-dfdebda76fb0",
  //         "title": "وصول متأخر",
  //         "body": "وصول متأخر"
  //     }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory ComplainResModel.fromMap(Map<String, dynamic> map) {
    return ComplainResModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplainResModel.fromJson(String source) => ComplainResModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ComplainResModel &&
      other.id == id &&
      other.title == title &&
      other.body == body;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode;
}
