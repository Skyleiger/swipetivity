import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const Section({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (title != null) _SectionTitle(title: title!),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer()
      ],
    );
  }
}
