import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/databaseHelper.dart';
import 'package:cise/database/userDatabaseModel.dart';
import 'package:cise/viewModel/profileState.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  TextEditingController usernameController = TextEditingController();

  String? sourceValue = "";
  String? destinationValue = "";

  // READ
  Future readAllData() async {
    try {
      emit(ProfileLoading());
      var user = await DatabaseHelper.instance.readAllUser();
      var tags = await DatabaseHelper.instance.readAllTag();
      var totalWords = await DatabaseHelper.instance.readAllWord();
      var memorizedWords = await DatabaseHelper.instance.readAllMemorizedWord();

      List<int> summary = [];

      int dailyMemorizedWords = 0;
      for (var x in memorizedWords) {
        final dateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(x.wordMemorizedDate ?? ""));

        final date = DateTime.now().difference(dateTime);

        if (date.inDays < 1) {
          dailyMemorizedWords ++;
        }
      }

      if (usernameController.text.isEmpty) {
        usernameController.text = user.first.userName.toString();
      }

      if (sourceValue!.isEmpty) {
        sourceValue = user.first.motherLanguage.toString();
      }

      if (destinationValue!.isEmpty) {
        destinationValue = user.first.foreignLanguage.toString();
      }

      summary.add(dailyMemorizedWords);
      summary.add(memorizedWords.length);
      summary.add(totalWords.length - memorizedWords.length);
      summary.add(totalWords.length);

      emit(ProfileLoaded(user.first, tags, summary));
    }
    catch (e) {
      emit(ProfileError());
    }
  }

  Future updateUser(User user) async {
    final result = await DatabaseHelper.instance.updateUser(user);
    emit(ProfileInitial());
  }

  changeSourceValue(String value) {
    sourceValue = value;
  }

  changeDestinationValue(String value) {
    destinationValue = value;
  }

  changeSourceToDestination() {
    String? data = destinationValue;
    destinationValue = sourceValue;
    sourceValue = data;
  }

}