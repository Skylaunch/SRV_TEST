import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/routes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.favorite),
              text: AppTexts.favoritesTitle,
            ),
            Tab(
              icon: Icon(Icons.local_grocery_store),
              text: AppTexts.itemsTitle,
            ),
            Tab(
              icon: Icon(Icons.person),
              text: AppTexts.userProfileTitle,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => context.push(favoritesScreenRoute),
                  child: const Text(AppTexts.favoritesTitle),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => context.push(itemsScreenRoute),
                  child: const Text(AppTexts.itemsTitle),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => context.push(userProfileScreenRoute),
                  child: const Text(AppTexts.userProfileTitle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
