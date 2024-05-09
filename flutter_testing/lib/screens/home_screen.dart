import 'package:flutter/material.dart';
import './util/screen_wrapper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      Center(
        child: ElevatedButton(
          child: const Text("Hmm..."),
          onPressed: () => Navigator.pushNamed(context, '/joke'),
        ),
      ),
    );
  }
}
