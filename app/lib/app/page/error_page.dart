import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Exception exception;

  const ErrorPage({super.key, required this.exception});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text("Error: $exception"),
      ),
    );
  }
}
