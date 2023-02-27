import 'package:flutter/material.dart';

SnackBar CustomSnackBar({required String text}) {
  return SnackBar(
    content: Builder(
      builder: (BuildContext context) {
        return Text(text, style: Theme.of(context).textTheme.bodySmall,);
      }
    ),
    duration: const Duration(milliseconds: 3000),
    showCloseIcon: true,
  );
}