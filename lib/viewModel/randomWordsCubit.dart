import 'package:cise/database/databaseHelper.dart';
import 'package:cise/database/wordDatabaseModel.dart';
import 'package:cise/service/WordService.dart';
import 'package:cise/viewModel/randomWordsState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomWordsCubit extends Cubit<RandomWordsState> {
  RandomWordsCubit() : super(RandomWordsInitial());

  String? sourceValue = "";
  String? destinationValue = "";

  final WordService _wordService = WordService();

  final PageController pageController = PageController(initialPage: 0);
  int page = 0;

  List<Map> wordList =  [];

  Future<void> readAllData() async {
    try {
      emit(RandomWordsLoading());
      var user = await DatabaseHelper.instance.readAllUser();

      if (sourceValue!.isEmpty) {
        sourceValue = user.first.motherLanguage.toString();
      }

      if (destinationValue!.isEmpty) {
        destinationValue = user.first.foreignLanguage.toString();
      }

      for (int i = 0; i < 3; i++) {
        await loadData();
      }

      //print(wordList);

      emit(RandomWordsLoaded());
    }
    catch (e) {
      emit(RandomWordsError());
    }

  }

  Future loadData() async {
    Map body = {
      "source": sourceValue,
      "destination": destinationValue
    };

    var response = await _wordService.postRandomTranslation(body);

    wordList.add(
      {
        sourceValue!.toUpperCase() : response["wordSource"],
        destinationValue!.toUpperCase() : response["wordDestination"]
      }
    );
  }

  Future createWord() async {

    Word word = Word(
        word: wordList[page].values.first,
        wordTranslated: wordList[page].values.last,
        sentence: "",
        sentenceTranslated: "",
        source: sourceValue,
        destination: destinationValue,
        wordAddedDate: DateTime.now().microsecondsSinceEpoch.toString(),
        wordMemorizedDate: "",
        isMemorized: 0,
        tagId: 0
    );

    Word result = await DatabaseHelper.instance.createWord(word);

    //print(result.toJson());
  }

  Future<void> changePage(int value) async {
    page = value;

    if (value == wordList.length - 2) {
      await loadData();
    }
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