class TranslateModel {
  String? word;
  String? sentence;
  String? source;
  String? destination;

  TranslateModel({
    this.word,
    this.sentence,
    this.source,
    this.destination,
  });

  TranslateModel copyWith({
    String? word,
    String? sentence,
    String? source,
    String? destination,
  }) =>
      TranslateModel(
        word: word ?? this.word,
        sentence: sentence ?? this.sentence,
        source: source ?? this.source,
        destination: destination ?? this.destination,
      );

  factory TranslateModel.fromJson(Map<String, dynamic> json) => TranslateModel(
    word: json["word"],
    sentence: json["sentence"],
    source: json["source"],
    destination: json["destination"],
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "sentence": sentence,
    "source": source,
    "destination": destination,
  };
}