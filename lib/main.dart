import 'package:cise/view/infoPage.dart';
import 'package:cise/view/randomWordsPage.dart';
import 'package:cise/view/weeklyReportPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:cise/view/addPage.dart';
import 'package:cise/view/homePage.dart';
import 'package:cise/view/onBoardingPages/onBoardingBasePage.dart';
import 'package:cise/view/settingsPage.dart';
import 'package:cise/view/splashScreen.dart';
import 'package:cise/viewModel/settingsCubit.dart';
import 'package:cise/viewModel/settingsState.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: ColorConstants.secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      )
  );

  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>(
                create: (context) => SettingsCubit()
            ),
            /*BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        )*/
          ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsInitial) {
          context.read<SettingsCubit>().chooseTheme();
          return MaterialApp(

          );
        }
        else if (state is SettingsLoaded){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "çise",
            theme: state.theme,
            routes: {
              '/': (context) => HomePage(),
              '/add' : (context) => AddPage(),
              '/splash': (context) => SplashScreen(),
              '/onBoarding': (context) => OnBoardingBasePage(),
              '/settings' : (context) => SettingsPage(),
              '/info' : (context) => InfoPage(),
              '/weekly' : (context) => WeeklyReportPage(),
              '/random' : (context) => RandomWordsPage(),
            },
            initialRoute: '/splash',
            //home: const SplashScreen(),
          );
        }
        else {
          return MaterialApp();
        }
      },
    );
  }
}