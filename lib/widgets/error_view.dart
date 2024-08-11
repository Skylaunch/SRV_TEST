import 'package:flutter/material.dart';
import 'package:srv_test/app_texts.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error?.toString() ?? AppTexts.defaultErrorText));
  }
}
