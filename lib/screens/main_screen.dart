import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/app_texts.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentTabNumber) => child.goBranch(currentTabNumber),
        backgroundColor: const Color(0xffe0b9f6),
        currentIndex: child.currentIndex,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite, color: Colors.red),
            icon: Icon(Icons.favorite),
            label: AppTexts.favoritesTitle,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.local_grocery_store, color: Colors.red),
            icon: Icon(Icons.local_grocery_store),
            label: AppTexts.itemsTitle,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, color: Colors.red),
            icon: Icon(Icons.person),
            label: AppTexts.userProfileTitle,
          ),
        ],
      ),
    );
  }
}
