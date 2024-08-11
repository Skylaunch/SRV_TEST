import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/screens/auth_screen.dart';
import 'package:srv_test/screens/favourites_screen.dart';
import 'package:srv_test/screens/items_screen.dart';
import 'package:srv_test/screens/main_screen.dart';
import 'screens/user_profile_screen.dart';
import 'package:collection/collection.dart';

const String appTitle = AppTexts.appTitle;

const String authScreenRoute = '/';
const String favoritesScreenRoute = '/favorites_tab';
const String userProfileScreenRoute = '/user_profile_tab';
const String itemsScreenRoute = '/items_tab';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: authScreenRoute,
        builder: (context, state) => const AuthScreen(
          title: appTitle,
        ),
      ),
      StatefulShellRoute(
        navigatorContainerBuilder: (BuildContext context,
            StatefulNavigationShell navigationShell, List<Widget> children) {
          return ExtendedShellBranchContainer(
            currentIndex: navigationShell.currentIndex,
            children: children,
          );
        },
        builder: (context, state, child) => MainScreen(child: child),
        branches: <ExtendedShellBranch>[
          ExtendedShellBranch(
            saveState: false,
            routes: <RouteBase>[
              GoRoute(
                path: favoritesScreenRoute,
                builder: (context, state) => const FavouritesScreen(),
              ),
            ],
          ),
          ExtendedShellBranch(
            saveState: false,
            routes: <RouteBase>[
              GoRoute(
                path: itemsScreenRoute,
                builder: (context, state) => const ItemsScreen(),
              ),
            ],
          ),
          ExtendedShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: userProfileScreenRoute,
                builder: (context, state) => const UserProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class ExtendedShellBranch extends StatefulShellBranch {
  ExtendedShellBranch({
    this.saveState = true,
    super.initialLocation,
    super.navigatorKey,
    super.observers,
    super.restorationScopeId,
    required super.routes,
  });

  final bool saveState;
}

class ExtendedShellBranchContainer extends StatelessWidget {
  const ExtendedShellBranchContainer({
    required this.currentIndex,
    required this.children,
    super.key,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> stackItems = children
        .mapIndexed((i, e) => _buildRouteBranchContainer(
              context,
              currentIndex == i,
              e,
            ))
        .toList();

    final child = children[currentIndex];
    final branch = (child as dynamic).branch as ExtendedShellBranch;

    return Stack(
      children: [
        IndexedStack(
          index: currentIndex,
          children: stackItems,
        ),
        if (!branch.saveState) children[currentIndex],
      ],
    );
  }

  Widget _buildRouteBranchContainer(
    BuildContext context,
    bool isActive,
    Widget child,
  ) {
    final branch = (child as dynamic).branch as ExtendedShellBranch;
    if (!branch.saveState) return const SizedBox.shrink();

    return Offstage(
      offstage: !isActive,
      child: TickerMode(
        enabled: isActive,
        child: child,
      ),
    );
  }
}
