import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/models/user_model.dart';
import 'package:srv_test/routes.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.currentUser});

  final UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.userProfileTitle),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Text(
                currentUser?.login ?? AppTexts.emptyLoginedUsername,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ElevatedButton(
              child: const Text(AppTexts.logout),
              onPressed: () => context.go(authScreenRoute),
            ),
          ],
        ),
      ),
    );
  }
}
