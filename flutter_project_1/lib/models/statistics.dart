import 'dart:convert';

Statistics topicFromJson(String str) => Statistics.fromJson(json.decode(str));

String topicToJson(Statistics data) => json.encode(data.toJson());

class Statistics {
  int topicId;
  String topicName;
  int totalQuestionCount;
  int totalCorrectAnswerCount;

  Statistics({
    required this.topicId,
    required this.topicName,
    required this.totalQuestionCount,
    required this.totalCorrectAnswerCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        topicId: json["id"],
        topicName: json["name"],
        totalQuestionCount: json["total_question_count"],
        totalCorrectAnswerCount: json["total_correct_answer_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": topicId,
        "name": topicName,
        "total_question_count": totalQuestionCount,
        "total_correct_answer_count": totalCorrectAnswerCount,
      };
}
