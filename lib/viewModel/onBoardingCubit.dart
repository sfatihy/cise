import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/databaseHelper.dart';
import 'package:cise/database/userDatabaseModel.dart';
import 'package:cise/viewModel/onBoardingState.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  String? motherTongue = "en";
  String? foreignLanguage = "tr";

  TextEditingController nameController = TextEditingController();

  changeMotherTongue(var value) {
    motherTongue = value as String?;
    emit(OnBoardingRefresh());
  }

  changeForeignLanguage(String? value) {
    foreignLanguage = value;
    emit(OnBoardingRefresh());
  }

  Future createUser(User user) async {
    final result = await DatabaseHelper.instance.createUser(user);

    print(result);

    return result;
  }

}