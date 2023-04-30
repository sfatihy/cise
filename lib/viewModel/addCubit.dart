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

  TextEditingController tagNameController = TextEditingController();
  TextEditingController newTagNameController = TextEditingController();

  final WordService _wordService = WordService();

  Color colorController = ColorConstants.primaryColor;

  int tag = 0;

  // CREATE
  Future createData(Word word) async {
    try {

      Map body = {
        "word": word.word,
        "sentence": word.sentence,
        "source": word.source,
        "destination": word.destination
      };

      //print(body);

      var response = await _wordService.postTranslation(body);

      word.wordTranslated = response["word"];
      word.sentenceTranslated = response["sentence"] ?? " ";

      Word result = await DatabaseHelper.instance.createWord(word);

      //print(result.toJson());
      return result;

    }
    catch (e){
      print(e);
    }
  }

  Future createTag(Tag tag) async {

    try {
      Tag result = await DatabaseHelper.instance.createTag(tag);

      return result;
    }
    catch (e) {
      print(e);
    }

  }

  Future createRandomData() async {

    try {

      Map body = {
        "source": sourceValue,
        "destination": destinationValue
      };

      var response = await _wordService.postRandomTranslation(body);

      Word word = Word(
        word: response["wordSource"],
        wordTranslated: response["wordDestination"],
        sentence: response["sentenceSource"],
        sentenceTranslated: response["sentenceDestination"],
        source: sourceValue,
        destination: destinationValue,
        wordAddedDate: DateTime.now().microsecondsSinceEpoch.toString(),
        wordMemorizedDate: "",
        isMemorized: 0,
        tagId: tag
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

      emit(AddLoaded(user.first ,allTag, tag));
    }
    catch (e) {
      print(e);
    }
  }

  // UPDATE
  updateTag(Tag tag) async {
    try {
      Tag result = await DatabaseHelper.instance.updateTag(tag);

      return result;
    }
    catch (e) {
      print(e);
    }
  }

  // DELETE
  deleteTag(int id) async {
    try {
      await DatabaseHelper.instance.deleteTag(id);
    }
    catch (e) {
      print(e);
    }
  }


  // CHANGE
  changeTag(int id) {

    print(id);

    if (tag == id) {
      tag = 0;
    }
    else {
      tag = id;
    }
  }

  changeColor(Color c) {
    colorController = c;
    //print(colorController);
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