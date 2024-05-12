import 'package:flutter/material.dart';
import 'package:flutter_project_1/models/answer.dart';
import 'package:flutter_project_1/models/quiz.dart';
import 'package:flutter_project_1/models/statistics.dart';
import 'package:flutter_project_1/providers/quiz_provider.dart';
import 'package:flutter_project_1/providers/statistics_provider.dart';
import 'package:flutter_project_1/providers/topic_provider.dart';
import 'package:flutter_project_1/services/quiz_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MCQForm extends ConsumerStatefulWidget {
  const MCQForm({super.key});

  @override
  ConsumerState<MCQForm> createState() => _MCQState();
}

class _MCQState extends ConsumerState<MCQForm> {
  List<String> wrongAnswers = [];
  String correctAnswer = "49";
  bool isCorrect = false;

  _resetStates() {
    setState(() {
      isCorrect = false;
      wrongAnswers = [];
    });
  }

  Future<void> _loadAnswer(Quiz quiz) async {
    final quizApi = QuizApi();
    final Answer response = await quizApi.fetchAnswer(quiz.answerPostPath);
    setState(() {
      correctAnswer = response.answer;
    });
  }

  Future<void> _loadNextQuestion() async {
    final quizNotifier = ref.watch(quizNotifierProvider);
    final topic = ref.watch(topicProvider);
    final Quiz quiz = await quizNotifier.updateQuiz(topic?.questionPath);
    await _loadAnswer(quiz);
  }

  _nextQuestion() async {
    await _loadNextQuestion();
    _resetStates();
  }

  _handleStatistics(bool isCorrect) {
    final topic = ref.watch(topicProvider);
    final statistics = ref.watch(statisticsProvider);
    final int currentStatisticsIndex =
        statistics.indexWhere((element) => element.topicId == topic!.id);
    final List<Statistics> updatedStatisticsList = statistics;
    final Statistics updateStatistics =
        updatedStatisticsList[currentStatisticsIndex];
    updatedStatisticsList[currentStatisticsIndex] = Statistics(
        topicId: updateStatistics.topicId,
        topicName: updateStatistics.topicName,
        totalQuestionCount: updateStatistics.totalQuestionCount + 1,
        totalCorrectAnswerCount:
            updateStatistics.totalCorrectAnswerCount + (isCorrect ? 1 : 0));
    ref.read(statisticsProvider.notifier).update(updatedStatisticsList);
  }

  _checkAnswer(Quiz? quiz, String option) async {
    if (quiz != null) {
      String correctOption = "18";
      // String correctOption = correctAnswer;
      if (correctOption == "") {
        // final quizApi = QuizApi();
        // final Answer response = await quizApi.fetchAnswer(quiz.answerPostPath);
        // print(response);
        // correctOption = response.answer;
      }
      if (option == correctOption) {
        setState(() {
          isCorrect = true;
          correctAnswer = correctOption;
        });
        if (wrongAnswers.isEmpty) {
          _handleStatistics(true);
        }
      } else {
        if (wrongAnswers.isEmpty) {
          _handleStatistics(false);
        }
        setState(() {
          wrongAnswers = [...wrongAnswers, option];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizNotifier = ref.watch(quizNotifierProvider);
    // final currTopic = ref.watch(topicProvider);
    final answerOptions = quizNotifier.quiz?.options != null
        ? quizNotifier.quiz!.options
            .map((option) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: OutlinedButton(
                    onPressed: (isCorrect || wrongAnswers.contains(option))
                        ? null
                        : () => _checkAnswer(quizNotifier.quiz, option),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return BorderSide(
                              color: isCorrect && option == correctAnswer
                                  ? Colors.green
                                  : wrongAnswers.contains(option)
                                      ? Colors.red
                                      : Colors.purple,
                              width: 2,
                            );
                          }
                          return BorderSide(
                            color: isCorrect && option == correctAnswer
                                ? Colors.green
                                : wrongAnswers.contains(option)
                                    ? Colors.red
                                    : Colors.purple,
                          );
                        },
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isCorrect && option == correctAnswer
                            ? Colors.green
                            : wrongAnswers.contains(option)
                                ? Colors.red
                                : Colors.purple,
                      ),
                    ))))
            .toList()
        : <Widget>[];
    return quizNotifier.quiz != null
        ? Column(children: [
            Text(quizNotifier.quiz?.question ?? ""),
            const SizedBox(height: 20),
            quizNotifier.quiz?.imageUrl != null
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Image.network(quizNotifier.quiz?.imageUrl ?? ""))
                : const SizedBox(),
            ...answerOptions,
            const SizedBox(height: 10),
            quizNotifier.quiz?.imageUrl != null
                ? const SizedBox(height: 20)
                : const SizedBox(),
            isCorrect
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FilledButton(
                      onPressed: _nextQuestion,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      child: const Text('Next'),
                    ),
                  )
                : const SizedBox(),
          ])
        : const Text("Quiz is loading!");
  }
}
