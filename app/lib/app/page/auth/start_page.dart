import 'package:flutter/material.dart';
import 'package:swipetivity_app/app/routing/routes.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.1,
          horizontal: size.width * 0.1,
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: size.height * 0.4,
                height: size.width * 0.3,
                child: const FittedBox(
                  child: Icon(Icons.interests),
                ),
              ),
              Text(
                "Swipetivity",
                style: themeData.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                "Bitte treffe eine Auswahl um zu starten.",
                style: themeData.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () => _onLoginButtonPressed(context),
                child: Text(
                  "Einloggen",
                  style: themeData.textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              ElevatedButton(
                onPressed: () => _onRegisterButtonPressed(context),
                child: Text(
                  "Registrieren",
                  style: themeData.textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    AuthLoginRoute().push(context);
  }

  void _onRegisterButtonPressed(BuildContext context) {
    AuthRegisterRoute().push(context);
  }
}
