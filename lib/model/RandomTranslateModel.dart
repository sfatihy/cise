class RandomTranslateModel {
  String? source;
  String? destination;

  RandomTranslateModel({
    this.source,
    this.destination,
  });

  RandomTranslateModel copyWith({
    String? source,
    String? destination,
  }) =>
      RandomTranslateModel(
        source: source ?? this.source,
        destination: destination ?? this.destination,
      );

  factory RandomTranslateModel.fromJson(Map<String, dynamic> json) => RandomTranslateModel(
    source: json["source"],
    destination: json["destination"],
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "destination": destination,
  };
}