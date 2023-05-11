class RandomTranslateResponseModel {
  String wordSource;
  String wordDestination;
  String sentenceSource;
  String sentenceDestination;

  RandomTranslateResponseModel({
    required this.wordSource,
    required this.wordDestination,
    required this.sentenceSource,
    required this.sentenceDestination,
  });

  RandomTranslateResponseModel copyWith({
    String? wordSource,
    String? wordDestination,
    String? sentenceSource,
    String? sentenceDestination,
  }) =>
      RandomTranslateResponseModel(
        wordSource: wordSource ?? this.wordSource,
        wordDestination: wordDestination ?? this.wordDestination,
        sentenceSource: sentenceSource ?? this.sentenceSource,
        sentenceDestination: sentenceDestination ?? this.sentenceDestination,
      );

  factory RandomTranslateResponseModel.fromJson(Map<String, dynamic> json) => RandomTranslateResponseModel(
    wordSource: json["wordSource"],
    wordDestination: json["wordDestination"],
    sentenceSource: json["sentenceSource"],
    sentenceDestination: json["sentenceDestination"],
  );

  Map<String, dynamic> toJson() => {
    "wordSource": wordSource,
    "wordDestination": wordDestination,
    "sentenceSource": sentenceSource,
    "sentenceDestination": sentenceDestination,
  };
}