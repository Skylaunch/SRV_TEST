class AppTexts {
  // Titles
  static const String userProfileTitle = 'Профиль';
  static const String favoritesTitle = 'Избранное';
  static const String itemsTitle = 'Товары';

  static const String appTitle = 'SRV_TEST';

  // Texts
  static const String inputLoginText = 'Введите свой логин:';
  static const String loginFieldHint = 'Логин';
  static const String loginFieldLabel = 'Логин';
  static const String passwordFieldHint = 'Пароль';
  static const String passwordFieldLabel = 'Пароль';
  static const String loginButtonText = 'Войти или зарегестрироваться';
  static const String emptyFavoritesText = 'У вас пока нет избранных товаров';
  static const String logout = 'Выход';
  static const String loading = 'Загрузка...';

  // Errors
  static const String emptyLoginFieldError = 'Введите логин';
  static const String emptyPasswordFieldError = 'Пожалуйста ввведите пароль';
  static const String emptyLoginedUsername = 'Ошибка в сохранении пользователя';
  static const String badPasswordLengthError =
      'Пароль не может содержать меньше 8 символов';
  static const String passwordFieldValidationError =
      'Пароль должен содержать минимум один символ из списка: (?=.*?[#!@\$%^&*-])';

  // Regexes
  static const String passwordValidationRegex = r'(?=.*?[#!@$%^&*-])';
}
