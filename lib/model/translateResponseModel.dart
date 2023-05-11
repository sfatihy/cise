class TranslateResponseModel {
  String word;
  String? sentence;

  TranslateResponseModel({
    required this.word,
    this.sentence,
  });

  TranslateResponseModel copyWith({
    String? word,
    String? sentence,
  }) =>
      TranslateResponseModel(
        word: word ?? this.word,
        sentence: sentence ?? this.sentence,
      );

  factory TranslateResponseModel.fromJson(Map<String, dynamic> json) => TranslateResponseModel(
    word: json["word"],
    sentence: json["sentence"],
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "sentence": sentence,
  };
}