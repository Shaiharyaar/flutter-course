import 'dart:convert';
import 'package:flutter_project_1/models/topic.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://dad-quiz-api.deno.dev/topics';

class TopicApi {
  Future<List<Topic>> findAll() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );
    List<dynamic> topicItems = jsonDecode(response.body);
    return List<Topic>.from(topicItems.map(
      (jsonData) => Topic.fromJson(jsonData),
    ));
  }
}
