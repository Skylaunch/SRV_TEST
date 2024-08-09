import 'package:firebase_database/firebase_database.dart';
import 'package:srv_test/models/user_model.dart';

class UsersDataProvider {
  UserModel? _currentUser;

  setCurrentUser(UserModel newCurrentUser) {
    _currentUser = newCurrentUser;
  }

  UserModel? getCurrentUser() {
    return _currentUser;
  }

  Future<void> registerIfNeeded(String login, String password) async {
    final users = FirebaseDatabase.instance.ref().child("Users");
    final event = await users.once();

    for (final child in event.snapshot.children) {
      final user = (child.value as Map<Object?, Object?>);
      if (user['login'] == login && user['password'] == password) {
        setCurrentUser(
          UserModel(
            login: login,
            password: password,
            favoritesIds: (user['favorite_items_list'] as String).split(','),
            key: child.key,
          ),
        );
        return;
      }
    }

    _registerUser(login, password);
  }

  void _registerUser(String login, String password) {
    Map<String, String> user = {
      'login': login,
      'password': password,
      'favorite_items_list': '',
    };

    final users = FirebaseDatabase.instance.ref().child("Users");

    final newUserRef = users.push();

    setCurrentUser(
      UserModel(
        login: login,
        password: password,
        favoritesIds: [''],
        key: newUserRef.key,
      ),
    );

    newUserRef.set(user);
  }
}
