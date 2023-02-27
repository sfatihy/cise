
import 'package:cise/database/wordDatabaseFields.dart';

class Word {

  int? id;
  String? word;
  String? wordTranslated;
  String? sentence;
  String? sentenceTranslated;
  String? source;
  String? destination;
  String? wordAddedDate;
  String? wordMemorizedDate;
  int? isMemorized;
  int? tagId;

  Word({
    this.id,
    required this.word,
    required this.wordTranslated,
    required this.sentence,
    required this.sentenceTranslated,
    required this.source,
    required this.destination,
    required this.wordAddedDate,
    required this.wordMemorizedDate,
    required this.isMemorized,
    required this.tagId,
  });

  Word copy({
    int? id,
    String? word,
    String? wordTranslated,
    String? sentence,
    String? sentenceTranslated,
    String? source,
    String? destination,
    String? wordAddedDate,
    String? wordMemorizedDate,
    int? isMemorized,
    int? tagId
  }) => Word(
      id: id ?? this.id,
      word: word ?? this.word,
      wordTranslated: wordTranslated ?? this.wordTranslated,
      sentence: sentence ?? this.sentence,
      sentenceTranslated: sentenceTranslated ?? this.sentenceTranslated,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      wordAddedDate: wordAddedDate ?? this.wordAddedDate,
      wordMemorizedDate: wordMemorizedDate ?? this.wordMemorizedDate,
      isMemorized: isMemorized ?? this.isMemorized,
      tagId: tagId ?? this.tagId
    );

  static Word fromJson(Map<String, Object?> json) => Word(
    id: json[WordDatabaseFields.id] as int?,
    word: json[WordDatabaseFields.word] as String?,
    wordTranslated: json[WordDatabaseFields.wordTranslated] as String?,
    sentence: json[WordDatabaseFields.sentence] as String?,
    sentenceTranslated: json[WordDatabaseFields.sentenceTranslated] as String?,
    source: json[WordDatabaseFields.source] as String?,
    destination: json[WordDatabaseFields.destination] as String?,
    wordAddedDate: json[WordDatabaseFields.wordAddedDate] as String?,
    wordMemorizedDate: json[WordDatabaseFields.wordMemorizedDate] as String?,
    isMemorized: json[WordDatabaseFields.isMemorized] as int?,
    tagId: json[WordDatabaseFields.tagId] as int?
  );

  Map<String, Object?> toJson() => {
    WordDatabaseFields.id : id,
    WordDatabaseFields.word : word,
    WordDatabaseFields.wordTranslated : wordTranslated,
    WordDatabaseFields.sentence : sentence,
    WordDatabaseFields.sentenceTranslated : sentenceTranslated,
    WordDatabaseFields.source : source,
    WordDatabaseFields.destination : destination,
    WordDatabaseFields.wordAddedDate : wordAddedDate,
    WordDatabaseFields.wordMemorizedDate : wordMemorizedDate,
    WordDatabaseFields.isMemorized : isMemorized,
    WordDatabaseFields.tagId : tagId
  };



}
