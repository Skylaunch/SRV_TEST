class UserModel {
  String? key;
  final String login;
  final String password;
  List<String> favoritesIds;

  bool isItemFavorite(String key) => favoritesIds.contains(key);

  UserModel({
    required this.key,
    required this.login,
    required this.password,
    required this.favoritesIds,
  });

  UserModel copyWith({
    String? key,
    String? login,
    String? password,
    List<String>? favoritesIds,
  }) {
    return UserModel(
      key: key ?? this.key,
      login: login ?? this.login,
      password: password ?? this.password,
      favoritesIds: favoritesIds ?? this.favoritesIds,
    );
  }
}
