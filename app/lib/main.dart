import 'package:flutter/material.dart';
import 'package:swipetivity_app/app/app.dart';
import 'package:swipetivity_app/localization/translations.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  runApp(const App());
}