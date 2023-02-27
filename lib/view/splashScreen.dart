import 'dart:async';

import 'package:cise/product/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cise/database/databaseHelper.dart';
import 'package:cise/product/imageConstants.dart';
import 'package:cise/product/localeKeys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double iconHeight = 256;
  double iconWidth = 256;

  bool animateBool = false;

  Future userCheck() async {
    final result = await DatabaseHelper.instance.readAllUser();

    if (result.isEmpty) {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingBasePage()));
      //Navigator.pushReplacementNamed(context, '/onBoarding');
      Navigator.pushNamedAndRemoveUntil(context, '/onBoarding', (route) => false);
    }
    else {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      //Navigator.pushReplacementNamed(context, '/');
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 1000)).then((value) => setState((){
      animateBool = true;
    }));

    Timer(Duration(milliseconds: 3000), () {
      userCheck();
    });
  }

  List text = [1.2,1.3,1.4];

  List<Widget> widgets= [];

  @override
  Widget build(BuildContext context) {

    /*widgets.add(Image.network(
      'https://images.unsplash.com/photo-1503435824048-a799a3a84bf7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80 4567t8y79e',
      fit: BoxFit.cover,
    ));*/

    /*widgets.add(
      Container(
        color: Colors.black,
        height: double.infinity,
      )
    );*/

    /*for (double i = -1.2; i>-4.0; i = i -0.1) {
      for (double j = -1.0; j<3.0; j = j + 0.1) {
        widgets.add(
            CustomRainEffect(x: j, y: i)
        );
        //print("${i.toString()}, ${j.toString()}");
      }
    }*/

    var sizeData = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: ColorConstants.primaryColor,//Theme.of(context).colorScheme.primary,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1500),
              height: animateBool ? sizeData.height : iconHeight,
              width: animateBool ? sizeData.width : iconWidth,
              curve: Curves.elasticIn,
              decoration: BoxDecoration(
                color: ColorConstants.secondaryColor, //Theme.of(context).colorScheme.secondary,
                shape: animateBool ? BoxShape.rectangle : BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(ImageConstants.logo)
              )
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: sizeData.height -75, bottom: 25),
            child: Text(LocaleKeys.splashScreen.value, style: Theme.of(context).textTheme.bodyMedium,),
          ),
        ),
        Lottie.network(
          ImageConstants.rainLottie,
          fit: BoxFit.fill,
          errorBuilder: (context, url, error) => Container(),
        )
      ]
    );
  }
}
