import 'package:flutter_project_1/providers/shared_preference_provider.dart';
import 'package:flutter_project_1/util/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genericProvider = StateProvider<bool>((ref) {
  const key = SharedKeyConstants.generic;
  final preferences = ref.watch(sharedPreferencesProvider);
  final currentValue = preferences.getBool(key) ?? false;
  ref.listenSelf((prev, curr) {
    preferences.setBool(key, curr);
  });
  return currentValue;
});
