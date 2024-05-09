import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import '../widgets/welcome_screen_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Welcome!'),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text("Home"),
              )
            ]),
      ),
    );
  }
}
