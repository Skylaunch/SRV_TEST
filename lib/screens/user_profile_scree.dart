import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/data_providers/users_data_provider.dart';
import 'package:srv_test/routes.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
                UsersDataProvider.currentUser?.login ??
                    AppTexts.emptyLoginedUsername,
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
