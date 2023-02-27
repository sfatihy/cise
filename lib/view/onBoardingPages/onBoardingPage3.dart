import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/product/appConstants.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:cise/product/imageConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/viewModel/onBoardingCubit.dart';

Stack OnBoardingPage3(BuildContext context) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Image.network(
        ImageConstants.onBoardingPage3,
        fit: BoxFit.cover,
        errorBuilder: (context, url, error) => Image.asset(ImageConstants.logo),
      ),
      Align(
        alignment: Alignment(-0.6, -0.6),
        child: Text(
          LocaleKeys.onBoardingPage3.value, style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: ColorConstants.textWhiteColor),
        ),
      ),
      Align(
        alignment: Alignment(0.5,-0.25),
        child: Container(
          color: ColorConstants.backgroundDarkAccentColor,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: context.read<OnBoardingCubit>().foreignLanguage,
              items: AppConstants.languages.map((key, value) {
                return MapEntry(key, DropdownMenuItem(
                  value: key,
                  child: Text(value)
                )
                );
              }).values.toList(),
              alignment: Alignment.center,
              style: Theme.of(context).textTheme.bodySmall,
              dropdownColor: ColorConstants.backgroundDarkAccentColor,
              onChanged: (newValue) {
                context.read<OnBoardingCubit>().changeForeignLanguage(newValue.toString());
                context.read<OnBoardingCubit>().refresh();
              },
            ),
          ),
        ),
      ),
    ],
  );
}