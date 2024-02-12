import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipetivity_app/routing/routes.dart';
import 'package:swipetivity_app/localization/translations.g.dart';

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
              SvgPicture.asset(
                "assets/icons/logo/logo-small.svg",
                semanticsLabel: "Swipetivity Logo",
                height: size.height * 0.2,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                context.translations.startPage.title,
                style: themeData.textTheme.displaySmall!.copyWith(),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              ElevatedButton(
                onPressed: () => _onRegisterButtonPressed(context),
                child: Text(
                  context.translations.startPage.registerButton,
                  style: themeData.textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              ElevatedButton(
                onPressed: () => _onLoginButtonPressed(context),
                child: Text(
                  context.translations.startPage.loginButton,
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
    const LoginPageRoute().push(context);
  }

  void _onRegisterButtonPressed(BuildContext context) {
    const RegisterPageRoute().push(context);
  }
}
