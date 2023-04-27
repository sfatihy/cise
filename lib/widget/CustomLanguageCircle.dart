import 'package:flutter/material.dart';

class CustomLanguageCircle extends StatelessWidget {
  const CustomLanguageCircle({Key? key, this.lang}) : super(key: key);

  final lang;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2
        )
      ),
      padding: const EdgeInsets.all(10),
      child: Text(lang),
    );
  }
}