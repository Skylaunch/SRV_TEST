import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/routes.dart';

class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('favourites_screen_title'),
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
