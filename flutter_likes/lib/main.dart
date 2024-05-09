import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stringListProvider = StateProvider<List<String>>((ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final currentValue = preferences.getStringList('data') ?? [];
  ref.listenSelf((prev, curr) {
    preferences.setStringList('data', curr);
  });
  return currentValue;
});

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

main() async {
  final prefs = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: TextApp(),
  ));
}

class TextApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: TextWidget()));
  }
}

class TextWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(stringListProvider);
    return Column(children: [
      ElevatedButton(
          onPressed: () => ref.read(stringListProvider.notifier).state = [
                ...ref.read(stringListProvider.notifier).state,
                "${ref.read(stringListProvider.notifier).state.length + 1}"
              ],
          child: Text(
              "Items: ${ref.read(stringListProvider.notifier).state.length}")),
      ...ref
          .read(stringListProvider.notifier)
          .state
          .map((e) => Text(e))
          .toList(),
    ]);
  }
}
