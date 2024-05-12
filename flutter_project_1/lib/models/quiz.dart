class Quiz {
  final int id;
  final String question;
  final List<dynamic> options;
  final String answerPostPath;
  final String? imageUrl;

  Quiz.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData['id'],
        question = jsonData['question'],
        options = jsonData['options'],
        answerPostPath = jsonData['answer_post_path'],
        imageUrl = jsonData['image_url'];
}
