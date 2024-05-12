import 'dart:convert';
import 'package:flutter_project_1/models/topic.dart';
import 'package:flutter_project_1/providers/shared_preference_provider.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicNotifier extends StateNotifier<Topic?> {
  final SharedPreferences prefs;
  TopicNotifier(this.prefs) : super(null);

  _initialize() {
    if (!prefs.containsKey(SharedKeyConstants.topic)) {
      return;
    }

    dynamic topic = json.decode(prefs.getString(SharedKeyConstants.topic)!);
    state = Topic.fromJson(topic);
  }

  updateTopic(Topic topic) {
    state = topic;
    prefs.setString(SharedKeyConstants.topic, json.encode(state!.toJson()));
  }
}

final topicProvider = StateNotifierProvider<TopicNotifier, Topic?>((ref) {
  final tn = TopicNotifier(ref.watch(sharedPreferencesProvider));
  tn._initialize();
  return tn;
});
