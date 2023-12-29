import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:swipetivity_app/app_module.dart';

void main() {
  Modular.setInitialRoute("/auth/start");
  runApp(ModularApp(module: AppModule(), child: const SwipetivityApp()));
}

class SwipetivityApp extends StatelessWidget {
  const SwipetivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Swipetivity",
      theme: _getLightThemeData(),
      darkTheme: _getDarkThemeData(),
      themeMode: ThemeMode.light,
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _getLightThemeData() {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color.fromRGBO(5, 68, 94, 1),
        onPrimary: Color.fromRGBO(24, 154, 180, 1),
        secondary: Color.fromRGBO(117, 230, 218, 1),
        onSecondary: Color.fromRGBO(212, 241, 244, 1),
      ),
      useMaterial3: true,
    );
  }

  ThemeData _getDarkThemeData() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: Color.fromRGBO(5, 68, 94, 1),
        onPrimary: Color.fromRGBO(24, 154, 180, 1),
        secondary: Color.fromRGBO(117, 230, 218, 1),
        onSecondary: Color.fromRGBO(212, 241, 244, 1),
      ),
      useMaterial3: true,
    );
  }
}
