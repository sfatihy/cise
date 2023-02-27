import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cise/product/colorConstants.dart';

ThemeData themeLight = ThemeData.light().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: ColorConstants.primaryColor,
    onPrimary: ColorConstants.primaryColor,
    secondary: ColorConstants.secondaryColor,
    onSecondary: ColorConstants.secondaryColor,
    error: ColorConstants.lightColor,
    onError: ColorConstants.lightColor,
    background: ColorConstants.backgroundLightColor,
    onBackground: ColorConstants.backgroundLightAccentColor,
    surface: ColorConstants.darkColor,
    onSurface: ColorConstants.lightColor
  ),
  primaryColor: ColorConstants.primaryColor,
  scaffoldBackgroundColor: ColorConstants.backgroundLightColor,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: ColorConstants.textBlackColor
    ),
    headlineMedium: TextStyle(),
    headlineSmall: TextStyle(
      color: ColorConstants.textBlackColor
    ),
    titleLarge: TextStyle(
        fontSize: 22,
        color: ColorConstants.textWhiteColor
    ),
    // ListTile -> title
    titleMedium: TextStyle(
        fontSize: 20,
        color: ColorConstants.textBlackColor
    ),
    titleSmall: TextStyle(
        fontSize: 18,
        color: ColorConstants.textWhiteColor
    ),
    bodyLarge: TextStyle(
        fontSize: 18,
        color: ColorConstants.textWhiteColor
    ),
    // ListTile -> leading, trailing
    bodyMedium: TextStyle(
        fontSize: 16,
        color: ColorConstants.textRedColor
    ),
    // Card -> subtitle
    bodySmall: TextStyle(
        fontSize: 14,
        color: ColorConstants.textBlackColor
    ),
  ),
  cardTheme: const CardTheme(
    color: ColorConstants.cardLightColor,
    margin: EdgeInsets.symmetric(horizontal: 8),
    shadowColor: ColorConstants.cardShadowLightColor,
    elevation: 8,
    shape: StadiumBorder(
      side: BorderSide(
        color: ColorConstants.cardBorderLightColor,
        width: 2
      )
    )
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorConstants.appBarBackgroundLightColor,
    foregroundColor: ColorConstants.appBarForegroundLightColor,
    titleTextStyle: TextStyle(
      color: ColorConstants.appBarTitleLightColor,
      fontSize: 24,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w300,
      letterSpacing: 4,
    ),
    centerTitle: true,
    iconTheme: IconThemeData(
        color: ColorConstants.appBarIconLightColor
    ),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  drawerTheme: const DrawerThemeData(
    width: 250,
    backgroundColor: ColorConstants.secondaryColor,
  ),
  iconTheme: const IconThemeData(
    color: ColorConstants.iconColor,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    iconSize: 28,
    foregroundColor: ColorConstants.floatingActionButtonForegroundColor,
    backgroundColor: ColorConstants.floatingActionButtonBackgroundColor,
    splashColor: ColorConstants.floatingActionButtonSplashColor,
    //hoverColor: Colors.lime,
    //focusColor: Colors.deepPurple
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: ColorConstants.navigationBarIndicatorColor,
    height: 60,
    backgroundColor: ColorConstants.navigationBarBackgroundColor,
    elevation: 0,
    iconTheme: MaterialStateProperty.all(
      const IconThemeData(
        color: ColorConstants.navigationBarIconColor,
      )
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColorConstants.buttonForegroundLightColor,
      backgroundColor: ColorConstants.buttonBackgroundLightColor,
      shadowColor: ColorConstants.buttonShadowLightColor,
      elevation: 4,
      side: const BorderSide(
        color: ColorConstants.buttonBorderSideLightColor,
        width: 2,
        style: BorderStyle.solid
      ),
      minimumSize: const Size(100, 50),
      shape: const StadiumBorder(),
    )
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: ColorConstants.primaryColor,
    alignment: Alignment.center,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16))
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    backgroundColor: ColorConstants.backgroundLightColor,
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: ColorConstants.cardLightColor,
    deleteIconColor: ColorConstants.cardShadowLightColor,
    shadowColor: ColorConstants.cardShadowLightColor,
    elevation: 8,
    shape: StadiumBorder(
      side: BorderSide(
        color: ColorConstants.cardBorderLightColor
      )
    ),
    labelStyle: TextStyle(
      color: ColorConstants.primaryColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    )
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: ColorConstants.backgroundLightAccentColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    textStyle: TextStyle(
      fontSize: 18,
      color: ColorConstants.primaryColor,
    )
  ),
  dividerTheme: const DividerThemeData(
    color: ColorConstants.primaryColor,
    thickness: 2
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: ColorConstants.primaryColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      side: BorderSide(
        color: ColorConstants.primaryColor,
        style: BorderStyle.solid,
        width: 1
      ),
    ),
  ),
);