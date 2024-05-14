import 'dart:math';
import 'dart:convert';

import 'package:flutter_project_1/models/statistics.dart';
import 'package:flutter_project_1/models/topic.dart';
import 'package:flutter_project_1/services/topics_api.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void _setStatisticsList(SharedPreferences prefs, List<Topic> topicsList) async {
  List<String>? statisticsListString =
      prefs.getStringList(SharedKeyConstants.statistics);
  if (statisticsListString == null || statisticsListString.isEmpty) {
    List<Statistics> statisticsList = [];
    for (final topic in topicsList) {
      final Statistics statistic = Statistics(
          topicId: topic.id,
          topicName: topic.name,
          totalQuestionCount: 0,
          totalCorrectAnswerCount: 0);
      statisticsList.add(statistic);
    }
    List<String> newStatisticsList =
        statisticsList.map((stats) => jsonEncode(stats.toJson())).toList();
    prefs.setStringList(SharedKeyConstants.statistics, newStatisticsList);
  }
}

Future<List<Topic>> _setTopicsList(SharedPreferences prefs) async {
  List<String>? topicsString =
      prefs.getStringList(SharedKeyConstants.topicList);

  if (topicsString == null || topicsString.isEmpty) {
    final topicApi = TopicApi();
    final topicsList = await topicApi.findAll();
    List<String> newTopics =
        topicsList.map((topic) => jsonEncode(topic.toJson())).toList();
    prefs.setStringList(SharedKeyConstants.topicList, newTopics);
    return topicsList;
  } else {
    return topicsString.map((e) => Topic.fromJson(json.decode(e))).toList();
  }
}

void setSharedPreferencesValues(SharedPreferences prefs) async {
  final topicsList = await _setTopicsList(prefs);
  _setStatisticsList(prefs, topicsList);
}

Future<Topic> getLeastCorrectAnswerTopic(
    List<Statistics> stats, List<Topic> topics) async {
  final topicCorrectCounts = <int, int>{};

  for (var stat in stats) {
    final count = topicCorrectCounts[stat.topicId] ?? 0;
    topicCorrectCounts[stat.topicId] = count + stat.totalCorrectAnswerCount;
  }

  final minCorrectCount = topicCorrectCounts.values.reduce(min);

  final leastCorrectTopics = topicCorrectCounts.entries
      .where((entry) => entry.value == minCorrectCount)
      .map((entry) => topics.firstWhere((topic) => topic.id == entry.key))
      .toList();

  final random = Random();
  final randomTopic =
      leastCorrectTopics[random.nextInt(leastCorrectTopics.length)];

  return randomTopic;
}
