import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/screens/auth_screen.dart';
import 'package:srv_test/screens/favourites_screen.dart';

final nameProvider = Provider<String>((ref) {
  return 'Max';
});

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

  FirebaseDatabase database = FirebaseDatabase.instance;

  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthScreen(title: 'SRV_TEST'),
    ),
    GoRoute(
      path: 'favorites',
      builder: (context, state) => const FavouritesScreen(),
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
