import 'dart:math';

import 'package:flutter/material.dart';

class CustomRainEffect extends StatefulWidget {
  CustomRainEffect({
    Key? key,
    required this.x,
    required this.y
  }) : super(key: key);

  double x;
  double y;

  @override
  State<CustomRainEffect> createState() => _CustomRainEffectState();
}

class _CustomRainEffectState extends State<CustomRainEffect> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {

    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 10)
    )..repeat(period: const Duration(seconds: 10));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Animation<Offset> _animation = Tween(begin: Offset(widget.x, widget.y), end: Offset(widget.x -3, widget.y + 3)).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));

    return SlideTransition(
      position: _animation,
      child: Transform.rotate(
        angle: pi/4,
        child: Image.asset("assets/rain.png", scale: 10,)
      ),
      /*child: Transform.rotate(
        angle: pi/4,
        child: Container(
          height: 20,
          width: 4,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),*/
    );
  }


  /*@override
  void initState() {
    for (int l = 0; l < 30; l++) {
      Timer(Duration(seconds: 5), () {
        setState(() {
          widget.y = widget.y + 0.1;
          widget.x = widget.x - 0.1;
        });
        print(widget.x);
        print(widget.y);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedAlign(
      alignment: Alignment(widget.x,widget.y),
      duration: Duration(seconds: 10),
      curve: Curves.easeInOutQuart,
      child: Transform.rotate(
        angle: pi/4,
        child: Container(
          height: 20,
          width: 4,
          margin: EdgeInsets.only(top: 56),
          decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        ),
      ),
    );

  }*/
}
