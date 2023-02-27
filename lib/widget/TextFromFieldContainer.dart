import 'package:flutter/material.dart';

class TextFormFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFormFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 20, top: 3, right: 20, bottom: 5),
      constraints: BoxConstraints(
        minHeight: size.height * 0.065,
        minWidth: size.width*0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).primaryColor,
      ),
      child: child
    );
  }
}