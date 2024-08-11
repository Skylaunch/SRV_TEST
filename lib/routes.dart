import 'package:go_router/go_router.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/screens/auth_screen.dart';
import 'package:srv_test/screens/favourites_screen.dart';
import 'package:srv_test/screens/items_screen.dart';
import 'package:srv_test/screens/main_screen.dart';
import 'screens/user_profile_screen.dart';

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
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) => MainScreen(child: child),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: favoritesScreenRoute,
                builder: (context, state) => const FavouritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: itemsScreenRoute,
                builder: (context, state) => const ItemsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
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
