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

  Future readData() async {
    try {
      emit(OnBoardingLoading());
      final tags = await DatabaseHelper.instance.readAllTag();
      print(tags.first.id);
      emit(OnBoardingLoaded(tags.first.id ?? 10));
    }
    catch (e) {
      print(e);
      emit(OnBoardingError());
    }
  }

  Future refresh() async {
    try {
      emit(OnBoardingLoading());
      //final user = await DatabaseHelper.instance.readAllUser();
      //print(user.first);
      //emit(OnBoardingLoaded());
    }
    catch (e) {
      print(e);
      emit(OnBoardingError());
    }
  }

  changeMotherTongue(var value) {
    motherTongue = value as String?;
  }

  changeForeignLanguage(String? value) {
    foreignLanguage = value;
  }

  Future createUser(User user) async {
    final result = await DatabaseHelper.instance.createUser(user);

    print(result);

    return result;
  }

}