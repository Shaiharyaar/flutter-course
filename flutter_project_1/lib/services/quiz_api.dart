import 'dart:convert';

import 'package:flutter_project_1/models/answer.dart';
import 'package:flutter_project_1/models/quiz.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://dad-quiz-api.deno.dev';

class QuizApi {
  Future<Quiz> fetchQuiz(path) async {
    final response = await http.get(
      Uri.parse("$baseUrl$path"),
    );
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return Quiz.fromJson(jsonData);
  }

  Future<Answer> fetchAnswer(path) async {
    final response = await http.get(
      Uri.parse("$baseUrl$path"),
    );
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return Answer.fromJson(jsonData);
  }
}
