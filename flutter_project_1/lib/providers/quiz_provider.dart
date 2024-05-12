import 'package:flutter/material.dart';
import 'package:flutter_project_1/models/quiz.dart';
import 'package:flutter_project_1/services/quiz_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizNotifier extends ChangeNotifier {
  Quiz? _quiz;

  Quiz? get quiz => _quiz;

  void setQuiz(Quiz? quiz) {
    _quiz = quiz;
    notifyListeners();
  }

  Future<Quiz> updateQuiz(String? parameter) async {
    final quizApi = QuizApi();

    final updatedQuiz = await quizApi.fetchQuiz(parameter);
    _quiz = updatedQuiz;
    notifyListeners();
    return updatedQuiz;
  }
}

final quizNotifierProvider = ChangeNotifierProvider<QuizNotifier>((ref) {
  return QuizNotifier();
});
