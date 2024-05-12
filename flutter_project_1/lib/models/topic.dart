import 'dart:convert';

Topic topicFromJson(String str) => Topic.fromJson(json.decode(str));

String topicToJson(Topic data) => json.encode(data.toJson());

class Topic {
  int id;
  String name;
  String questionPath;

  Topic({
    required this.id,
    required this.name,
    required this.questionPath,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        questionPath: json["question_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "question_path": questionPath,
      };
}
