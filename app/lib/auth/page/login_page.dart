import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Modular.to.pop(),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.1,
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Anmelden",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Text(
                "Bitte melde dich an.",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "E-Mail",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Passwort",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              TextButton(
                onPressed: () => Modular.to.pushNamed("/auth/forgot"),
                child: Text(
                  "Passwort vergessen?",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              ElevatedButton(
                onPressed: () => Modular.to.pushNamed("/dashboard"),
                child: Text(
                  "Anmelden",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
