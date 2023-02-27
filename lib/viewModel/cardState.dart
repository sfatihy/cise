import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/database/wordDatabaseModel.dart';

abstract class CardState {
  const CardState();
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  Word word;
  var tag;

  CardLoaded(this.word, this.tag);
}

class CardsLoaded extends CardState {
  final List<Word> words;
  final List<Tag> tags;
  final int tag;

  CardsLoaded(this.words, this.tags, this.tag);
}

class CardError extends CardState {
  final String errorType;

  CardError(this.errorType);
}