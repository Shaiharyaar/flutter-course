class Answer {
  final String answer;

  Answer.fromJson(Map<String, dynamic> jsonData) : answer = jsonData['answer'];
}
