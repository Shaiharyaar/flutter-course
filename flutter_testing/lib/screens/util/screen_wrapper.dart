import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget widget;
  const ScreenWrapper(this.widget);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DAD Jokes"),
      ),
      body: widget,
    );
  }
}
