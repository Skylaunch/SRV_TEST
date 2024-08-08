import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_test/app_texts.dart';
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
            const Text(AppTexts.inputLoginText),
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

                            context.go(mainScreenRoute);
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
        validator:
            RequiredValidator(errorText: AppTexts.emptyLoginFieldError).call,
        decoration: const InputDecoration(
          hintText: AppTexts.loginFieldHint,
          labelText: AppTexts.loginFieldLabel,
          prefixIcon: Icon(
            Icons.login_outlined,
            color: Colors.lightBlue,
          ),
          errorStyle: TextStyle(fontSize: 13.0),
          errorMaxLines: 2,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
        ),
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
        validator: MultiValidator(
          [
            RequiredValidator(errorText: AppTexts.emptyPasswordFieldError),
            MinLengthValidator(8, errorText: AppTexts.badPasswordLengthError),
            PatternValidator(
              AppTexts.passwordValidationRegex,
              errorText: AppTexts.passwordFieldValidationError,
            )
          ],
        ).call,
        decoration: const InputDecoration(
          hintText: AppTexts.passwordFieldHint,
          labelText: AppTexts.passwordFieldLabel,
          prefixIcon: Icon(
            Icons.key,
            color: Colors.green,
          ),
          errorStyle: TextStyle(fontSize: 13.0),
          errorMaxLines: 2,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
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
            AppTexts.loginButtonText,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
