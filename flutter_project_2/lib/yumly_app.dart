import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_2/routes/routes.dart';

class YumlyApp extends StatelessWidget {
  const YumlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.green,
    ));
    return MaterialApp.router(routerConfig: router);
  }
}
