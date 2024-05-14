class Answer {
  final bool correct;

  Answer.fromJson(Map<String, dynamic> jsonData)
      : correct = jsonData['correct'];
}
