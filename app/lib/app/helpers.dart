import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipetivity_app/localization/translations.g.dart';

void showConfirmDialog({
  required BuildContext context,
  required String title,
  required String description,
  String? cancelButtonText,
  VoidCallback? cancelButtonAction,
  String? confirmButtonText,
  VoidCallback? confirmButtonAction,
}) {
  cancelButtonAction ??= () => context.pop();
  confirmButtonAction ??= () => context.pop();

  Widget cancelButton = TextButton(
    onPressed: cancelButtonAction,
    child: Text(cancelButtonText ?? context.translations.dialog.confirm.cancelButton),
  );
  Widget confirmButton = TextButton(
    onPressed: confirmButtonAction,
    child: Text(confirmButtonText ?? context.translations.dialog.confirm.confirmButton),
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      cancelButton,
      confirmButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showInformationDialog({
  required BuildContext context,
  required String title,
  required String description,
  String? buttonText,
  VoidCallback? buttonAction,
}) {
  buttonAction ??= () => context.pop();

  Widget button = TextButton(
    onPressed: buttonAction,
    child: Text(buttonText ?? context.translations.dialog.information.closeButton),
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      button,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showNotImplementedDialog({required BuildContext context, String? title}) {
  showInformationDialog(
    context: context,
    title: title ?? context.translations.dialog.notImplemented.title,
    description: context.translations.dialog.notImplemented.description,
  );
}

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
