import 'dart:convert';

import 'package:flutter_project_1/models/topic.dart';
import 'package:flutter_project_1/providers/shared_preference_provider.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicListNotifier extends StateNotifier<List<Topic>> {
  final SharedPreferences prefs;
  final key = SharedKeyConstants.topicList;
  TopicListNotifier(this.prefs) : super([]);

  _initialize() {
    if (!prefs.containsKey(key)) {
      return;
    }

    final List<String> topicsListString = prefs.getStringList(key)!;
    state =
        topicsListString.map((e) => Topic.fromJson(json.decode(e))).toList();
  }

  update(List<Topic> newList) {
    List<String> newTopics =
        newList.map((topic) => jsonEncode(topic.toJson())).toList();
    prefs.setStringList(key, newTopics);
  }
}

final topicListProvider =
    StateNotifierProvider<TopicListNotifier, List<Topic>>((ref) {
  final tn = TopicListNotifier(ref.watch(sharedPreferencesProvider));
  tn._initialize();
  return tn;
});
