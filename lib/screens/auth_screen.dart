import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.title});

  final String title;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Map userData = {};
  final _formkey = GlobalKey<FormState>();

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
              key: _formkey,
              child: Column(
                children: [
                  const _PasswordField(),
                  _LoginButton(formKey: _formkey),
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
  const _LoginField();

  @override
  State<_LoginField> createState() => __LoginFieldState();
}

class __LoginFieldState extends State<_LoginField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({super.key});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
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
          errorStyle: TextStyle(fontSize: 18.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(9.0))),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.go('/details');
            }
          },
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
