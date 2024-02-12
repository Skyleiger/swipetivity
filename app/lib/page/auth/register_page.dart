import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/localization/translations.g.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => _onBackButtonPressed(context),
        ),
      ),
      body: Center(
        child: Text(
          context.translations.registerPage.title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _onBackButtonPressed(BuildContext context) {
    context.pop();
  }
}
