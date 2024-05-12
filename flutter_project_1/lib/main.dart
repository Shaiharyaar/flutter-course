import 'package:flutter/material.dart';
import 'package:flutter_project_1/providers/shared_preference_provider.dart';
import 'package:flutter_project_1/quiz_app.dart';
import 'package:flutter_project_1/util/handlers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // set initial states in shared preference if not set
  setSharedPreferencesValues(prefs);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const QuizApp(),
    ),
  );
}
