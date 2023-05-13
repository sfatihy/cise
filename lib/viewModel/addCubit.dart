import 'package:cise/model/RandomTranslateModel.dart';
import 'package:cise/model/RandomTranslateResponseModel.dart';
import 'package:cise/model/translateModel.dart';
import 'package:cise/model/translateResponseModel.dart';
import 'package:cise/product/colorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cise/database/databaseHelper.dart';
import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/database/wordDatabaseModel.dart';
import 'package:cise/service/WordService.dart';
import 'package:cise/viewModel/addState.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());

  String? sourceValue = "";
  String? destinationValue = "";

  final WordService _wordService = WordService();

  int currentTagIndex = 0;

  // CREATE
  Future createData(Word word) async {
    try {

      TranslateModel model = TranslateModel(
        word: word.word,
        sentence: word.sentence,
        source: word.source,
        destination: word.destination
      );

      //print(model.toJson());

      TranslateResponseModel response = await _wordService.postTranslation(model);

      word.wordTranslated = response.word;
      word.sentenceTranslated = response.sentence ?? " ";

      Word result = await DatabaseHelper.instance.createWord(word);

      //print(result.toJson());
      return result;

    }
    catch (e) {
      print(e);
    }
  }

  Future createRandomData() async {

    try {

      RandomTranslateModel model = RandomTranslateModel(
        source: sourceValue,
        destination: destinationValue
      );

      RandomTranslateResponseModel response = await _wordService.postRandomTranslation(model);

      Word word = Word(
        word: response.wordSource,
        wordTranslated: response.wordDestination,
        sentence: response.sentenceSource,
        sentenceTranslated: response.sentenceDestination,
        source: sourceValue,
        destination: destinationValue,
        wordAddedDate: DateTime.now().microsecondsSinceEpoch.toString(),
        wordMemorizedDate: "",
        isMemorized: 0,
        tagId: currentTagIndex
      );

      Word result = await DatabaseHelper.instance.createWord(word);

      print(result.toJson());
      return result;
    }
    catch (e){
      print(e);
    }

  }

  // READ
  Future readData() async {
    try {
      emit(AddLoading());
      final user = await DatabaseHelper.instance.readAllUser();
      var allTag = await DatabaseHelper.instance.readAllTag();

      if (sourceValue!.isEmpty) {
        sourceValue = user.first.motherLanguage.toString();
      }

      if (destinationValue!.isEmpty) {
        destinationValue = user.first.foreignLanguage.toString();
      }

      emit(AddLoaded(user.first ,allTag, currentTagIndex));
    }
    catch (e) {
      print(e);
    }
  }


  // CHANGE
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

  setCurrentIndexFromTagsRowCubit(int index) {
    currentTagIndex = index;
  }
}