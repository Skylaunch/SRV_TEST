import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/routes.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('user_profile_screen_title'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Обратно'),
          onPressed: () => context.go(authScreenRoute),
        ),
      ),
    );
  }
}
