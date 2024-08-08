import 'package:go_router/go_router.dart';
import 'package:srv_test/screens/auth_screen.dart';
import 'package:srv_test/screens/favourites_screen.dart';
import 'package:srv_test/screens/items_screen.dart';
import 'screens/user_profile_scree.dart';

const String appTitle = 'SRV_TEST';

const String authScreenRoute = '/';
const String favoritesScreenRoute = '/favorites';
const String userProfileScreenRoute = '/user_profile';
const String itemsScreenRoute = '/items';

final router = GoRouter(
  routes: [
    GoRoute(
      path: authScreenRoute,
      builder: (context, state) => const AuthScreen(title: appTitle),
    ),
    GoRoute(
      path: favoritesScreenRoute,
      builder: (context, state) => const FavouritesScreen(),
    ),
    GoRoute(
      path: userProfileScreenRoute,
      builder: (context, state) => const UserProfileScreen(),
    ),
    GoRoute(
      path: itemsScreenRoute,
      builder: (context, state) => const ItemsScreen(),
    )
  ],
);
