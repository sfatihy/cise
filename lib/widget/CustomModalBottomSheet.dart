import 'package:flutter/material.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/widget/CustomHeightSpace.dart';

class CustomModalBottomSheet extends StatelessWidget {
  CustomModalBottomSheet({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstants.allPadding,
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50,
              height: 3,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const CustomHeightSpace(),
          widget
      ],
    ),
    );
  }
}
