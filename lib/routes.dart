import 'package:go_router/go_router.dart';
import 'package:srv_test/app_texts.dart';
import 'package:srv_test/data_providers/users_data_provider.dart';
import 'package:srv_test/screens/auth_screen.dart';
import 'package:srv_test/screens/favourites_screen.dart';
import 'package:srv_test/screens/items_screen.dart';
import 'package:srv_test/screens/main_screen.dart';
import 'screens/user_profile_scree.dart';

const String appTitle = AppTexts.appTitle;

const String authScreenRoute = '/';
const String favoritesScreenRoute = '/favorites';
const String userProfileScreenRoute = '/user_profile';
const String itemsScreenRoute = '/items';
const String mainScreenRoute = '/main';

class AppRouter {
  final UsersDataProvider usersDataProvider;

  AppRouter({
    required this.usersDataProvider,
  });

  GoRouter getRouter() {
    final currentUser = usersDataProvider.getCurrentUser();

    return GoRouter(
      routes: [
        GoRoute(
          path: authScreenRoute,
          builder: (context, state) => const AuthScreen(
            title: appTitle,
          ),
        ),
        GoRoute(
          path: favoritesScreenRoute,
          builder: (context, state) => FavouritesScreen(
            currentUser: currentUser,
          ),
        ),
        GoRoute(
          path: userProfileScreenRoute,
          builder: (context, state) => UserProfileScreen(
            currentUser: currentUser,
          ),
        ),
        GoRoute(
          path: itemsScreenRoute,
          builder: (context, state) => ItemsScreen(
            currentUser: currentUser,
          ),
        ),
        GoRoute(
          path: mainScreenRoute,
          builder: (context, state) => const MainScreen(),
        ),
      ],
    );
  }
}
