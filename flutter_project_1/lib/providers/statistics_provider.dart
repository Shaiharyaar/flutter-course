import 'dart:convert';

import 'package:flutter_project_1/models/statistics.dart';
import 'package:flutter_project_1/providers/shared_preference_provider.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsNotifier extends StateNotifier<List<Statistics>> {
  final SharedPreferences prefs;
  final key = SharedKeyConstants.statistics;
  StatisticsNotifier(this.prefs) : super([]);

  _initialize() {
    if (!prefs.containsKey(key)) {
      return;
    }

    final List<String> statisticsListString = prefs.getStringList(key)!;
    state = statisticsListString
        .map((e) => Statistics.fromJson(json.decode(e)))
        .toList();
  }

  update(List<Statistics> newList) {
    List<String> newTopics =
        newList.map((topic) => jsonEncode(topic.toJson())).toList();
    prefs.setStringList(key, newTopics);
  }
}

final statisticsProvider =
    StateNotifierProvider<StatisticsNotifier, List<Statistics>>((ref) {
  final tn = StatisticsNotifier(ref.watch(sharedPreferencesProvider));
  tn._initialize();
  return tn;
});
