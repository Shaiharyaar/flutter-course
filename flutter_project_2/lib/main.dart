import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2/yumly_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseFirestore fs = FirebaseFirestore.instance;
  final snapshot = await fs.collection('notes').get();
  for (var doc in snapshot.docs) {
    print('${doc.id}: ${doc.data()}');
  }

  runApp(
    const ProviderScope(child: YumlyApp()),
  );
}
