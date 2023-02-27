import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cise/product/iconConstants.dart';
import 'package:cise/product/imageConstants.dart';
import 'package:cise/product/localeKeys.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.info.value),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconConstants.infoIcon,
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 4,),
              Image.asset(ImageConstants.logo),
              const Spacer(flex: 10,),
              Center(
                child: Text(LocaleKeys.splashScreen.value),
              ),
              const Spacer(flex: 1,)
            ],
          ),
          Lottie.network(
            ImageConstants.rainLottie,
            fit: BoxFit.fill,
            errorBuilder: (context, url, error) => Container(),
          ),
        ],
      ),
    );
  }
}