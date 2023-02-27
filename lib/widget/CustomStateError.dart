import 'package:flutter/material.dart';
import 'package:cise/widget/CustomHeightSpace.dart';

Center CustomStateError({required String error, required Future func}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error),
        const CustomHeightSpace(),
        OutlinedButton.icon(
          icon: const Icon(Icons.refresh_outlined),
          label: const Text("Try again"),
          onPressed: () {
            func;
          },
        ),
      ],
    ),
  );
}
