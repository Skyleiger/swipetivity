import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: const Center(
        child: Text(
          "Registieren",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _onBackButtonPressed(BuildContext context) {
    context.pop();
  }
}
