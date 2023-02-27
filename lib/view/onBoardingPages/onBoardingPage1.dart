import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:cise/product/imageConstants.dart';
import 'package:cise/product/localeKeys.dart';
import 'package:cise/viewModel/onBoardingCubit.dart';
import 'package:cise/widget/TextFromFieldContainer.dart';

Stack OnBoardingPage1(BuildContext context, GlobalKey formKey) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Image.network(
        ImageConstants.onBoardingPage1,
        fit: BoxFit.cover,
        errorBuilder: (context, url, error) => Image.asset(ImageConstants.logo),
      ),
      Align(
        alignment: Alignment(-0.6,-0.6),
        child: Text(LocaleKeys.onBoardingPage1.value, style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: ColorConstants.textBlackColor),),
      ),
      Align(
        alignment: Alignment(0,-0.2),
        child: Padding(
          padding: const EdgeInsets.only(left: 128.0, right: 32),
          child: Form(
            key: formKey,
            child: TextFormFieldContainer(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "username",
                  border: InputBorder.none,
                ),
                controller: context.read<OnBoardingCubit>().nameController,
                validator: (value) {
                  if (value!.length <= 2) {
                    return "Must be at least 2 characters";
                  }
                  else{
                    return null;
                  }
                },
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
