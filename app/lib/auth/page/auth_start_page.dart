import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthStartPage extends StatelessWidget {
  const AuthStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: height * 0.1,
          horizontal: width * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: width * 0.4,
              height: height * 0.3,
              child: const FittedBox(
                child: Icon(Icons.interests),
              ),
            ),
            Text(
              "Swipetivity",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                 fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Text(
              "Bitte treffe eine Auswahl um zu starten.",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () => Modular.to.pushNamed("/auth/login"),
              child: Text(
                "Einloggen",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            ElevatedButton(
              onPressed: () => Modular.to.pushNamed("/auth/register"),
              child: Text(
                "Registrieren",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Mit Community-PIN teilnehmen",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
