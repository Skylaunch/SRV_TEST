import 'package:firebase_database/firebase_database.dart';

class UsersDataProvider {
  Future<void> registerIfNeeded(String login, String password) async {
    final users = FirebaseDatabase.instance.ref().child("Users");
    final event = await users.once();

    for (final child in event.snapshot.children) {
      final user = (child.value as Map<Object?, Object?>);
      if (user['login'] == login && user['password'] == password) {
        return;
      }
    }

    _registerUser(login, password);
  }

  void _registerUser(String login, String password) {
    Map<String, String> user = {
      'login': login,
      'password': password,
    };

    final users = FirebaseDatabase.instance.ref().child("Users");

    users.push().set(user);
  }
}
