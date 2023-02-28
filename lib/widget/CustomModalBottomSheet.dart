import 'package:flutter/material.dart';
import 'package:cise/product/paddingConstants.dart';
import 'package:cise/widget/CustomHeightSpace.dart';

class CustomModalBottomSheet extends StatelessWidget {
  CustomModalBottomSheet({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double initialSize = size.height/1650;
    double maxSize = size.height/1450;
    double minSize = size.height/2500;

    print("initial -> ${initialSize}, \n"
          "max -> ${maxSize},\n"
          "min -> ${minSize}");

    double containerMax = size.height/(1.25 + maxSize);
    double containerMin = size.height/(1.1 + minSize);

    print("ContainerMax -> ${containerMax},\n"
          "ContainerMin -> ${containerMin}");

    return DraggableScrollableSheet(
      initialChildSize: initialSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      snap: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: PaddingConstants.allPadding,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
            height: containerMax,
            constraints: BoxConstraints(
              //minHeight: containerMin,
              //maxHeight: containerMax
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
          ),
        );
      },
    );
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
