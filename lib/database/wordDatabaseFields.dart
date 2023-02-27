final String tableWord = "words";

class WordDatabaseFields {

  static final List<String> values = [
    id,
    word, wordTranslated,
    sentence, sentenceTranslated,
    source, destination,
    wordAddedDate, wordMemorizedDate,
    isMemorized,
    tagId
  ];

  static final String id = "id";
  static final String word = "word";
  static final String wordTranslated = "wordTranslated";
  static final String sentence = "sentence";
  static final String sentenceTranslated = "sentenceTranslated";
  static final String source = "source";
  static final String destination = "destination";
  static final String wordAddedDate = "wordAddedDate";
  static final String wordMemorizedDate = "wordMemorizedDate";
  static final String isMemorized = "isMemorized";
  static final String tagId = "tagId";
}