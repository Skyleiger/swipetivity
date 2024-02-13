import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final bool defaultPadding;
  final Function(BuildContext context)? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.defaultPadding = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = this.child;

    if (defaultPadding) {
      child = Padding(
        padding: const EdgeInsets.all(30),
        child: child,
      );
    }

    if (onTap != null) {
      child = InkWell(
        onTap: () => onTap!(context),
        child: child,
      );
    }

    return Card(
      elevation: 4,
      clipBehavior: onTap != null ? Clip.hardEdge : Clip.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}

class AppButtonCard extends StatelessWidget {
  final List<CardButton> buttons;

  const AppButtonCard({
    super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    List<ListTile> tiles = buttons.map((button) {
      return ListTile(
        title: Text(button.title),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(button.icon),
        ),
        trailing: const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.arrow_forward_ios),
        ),
        onTap: () => button.onTap(context),
      );
    }).toList();

    return AppCard(
      defaultPadding: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: tiles,
        ),
      ),
    );
  }
}

class CardButton {
  final String title;
  final IconData icon;
  final Function(BuildContext context) onTap;

  const CardButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
