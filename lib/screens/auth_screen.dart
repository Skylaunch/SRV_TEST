import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/main.dart';
import 'package:srv_test/routes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.title});

  final String title;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Введите свой логин:',
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _LoginField(controller: _loginController),
                  _PasswordField(controller: _passwordController),
                  Consumer(
                    builder: (context, ref, child) {
                      return _LoginButton(
                        onAuthButtonPress: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(usersDataProvider).registerIfNeeded(
                                  _loginController.text,
                                  _passwordController.text,
                                );

                            context.go(itemsScreenRoute);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginField extends StatefulWidget {
  const _LoginField({required this.controller});

  final TextEditingController controller;

  @override
  State<_LoginField> createState() => __LoginFieldState();
}

class __LoginFieldState extends State<_LoginField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: TextFormField(
        controller: widget.controller,
        validator: RequiredValidator(errorText: 'Введите логин').call,
        decoration: const InputDecoration(
            hintText: 'Логин',
            labelText: 'Логин',
            prefixIcon: Icon(
              Icons.login_outlined,
              color: Colors.lightBlue,
            ),
            errorStyle: TextStyle(fontSize: 13.0),
            errorMaxLines: 2,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(9.0)))),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({required this.controller});

  final TextEditingController controller;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: TextFormField(
        controller: widget.controller,
        validator: MultiValidator([
          RequiredValidator(errorText: 'Пожалуйста ввведите пароль'),
          MinLengthValidator(8,
              errorText: 'Пароль не может содержать меньше 8 символов'),
          PatternValidator(r'(?=.*?[#!@$%^&*-])',
              errorText:
                  'Пароль должен содержать минимум один символ из списка: (?=.*?[#!@\$%^&*-])')
        ]).call,
        decoration: const InputDecoration(
          hintText: 'Пароль',
          labelText: 'Пароль',
          prefixIcon: Icon(
            Icons.key,
            color: Colors.green,
          ),
          errorStyle: TextStyle(fontSize: 13.0),
          errorMaxLines: 2,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(9.0))),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onAuthButtonPress});

  final Function() onAuthButtonPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
          onPressed: onAuthButtonPress,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.red),
          ),
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
