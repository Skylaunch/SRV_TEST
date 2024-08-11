import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srv_test/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAImmT75__oKirU8Qo1TOisIE7MydX01fU',
      appId: '1:1026758208223:android:6d1e8319d2f529d691976a',
      messagingSenderId: '1026758208223',
      projectId: 'fluttertest-88aa6',
      storageBucket: 'fluttertest-88aa6.appspot.com',
    ),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
    );
  }
}
