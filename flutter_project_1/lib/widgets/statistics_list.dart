import 'package:flutter/material.dart';
import 'package:flutter_project_1/providers/statistics_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StatisticsList extends ConsumerWidget {
  const StatisticsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statistics = ref.watch(statisticsProvider);
    final totalQuestions = statistics.fold<int>(0, (previousValue, stats) {
      return previousValue + stats.totalQuestionCount;
    });
    final totalCorrectAnswers = statistics.fold<int>(0, (previousValue, stats) {
      return previousValue + stats.totalCorrectAnswerCount;
    });
    final totalWrongAnswers = totalQuestions - totalCorrectAnswers;
    final sortedStatistics = statistics.toList()
      ..sort((a, b) =>
          b.totalCorrectAnswerCount.compareTo(a.totalCorrectAnswerCount));

    final items = List<Widget>.from(sortedStatistics.map(
      (stats) => Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 1.0,
                        color:
                            Colors.black12), // Adjust width and color as needed
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Text(
                stats.topicName,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 2),
              Text(
                "Total questions: ${stats.totalQuestionCount}",
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 2),
              Text(
                "Total correct answers: ${stats.totalCorrectAnswerCount}",
                style: const TextStyle(fontSize: 12, color: Colors.green),
              ),
              const SizedBox(height: 2),
              Text(
                "Total wrong answers: ${stats.totalQuestionCount - stats.totalCorrectAnswerCount}",
                style: const TextStyle(fontSize: 12, color: Colors.red),
              )
            ],
          ),
        ),
      ),
    ));
    return items.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items,
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Shadow color
                        spreadRadius: 4, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Offset from the top
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Questions: $totalQuestions",
                            style: TextStyle(
                                fontSize: 16, color: Colors.purple.shade800),
                          ),
                          Text(
                            "Total Correct answers: $totalCorrectAnswers",
                            style: TextStyle(
                                fontSize: 16, color: Colors.purple.shade800),
                          ),
                          Text(
                            "Total Wrong answers: $totalWrongAnswers",
                            style: TextStyle(
                                fontSize: 16, color: Colors.purple.shade800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.arrow_back),
                )
              ],
            ),
          )
        : const Center(
            child: Text('Loading Statistics'),
          );
  }
}
