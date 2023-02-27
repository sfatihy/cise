
import 'package:cise/database/tagDatabaseFields.dart';

class Tag {

  int? id;
  String? tagName;
  String? tagCreatedDate;
  String? tagColor;

  Tag({
    this.id,
    required this.tagName,
    required this.tagCreatedDate,
    required this.tagColor
  });

  Tag copy({
    int? id,
    String? tagName,
    String? tagCreatedDate,
    String? tagColor
  }) => Tag(
      id: id ?? this.id,
      tagName: tagName ?? this.tagName,
      tagCreatedDate: tagCreatedDate ?? this.tagCreatedDate,
      tagColor: tagColor ?? this.tagColor
  );

  static Tag fromJson(Map<String, Object?> json) => Tag(
    id: json[TagDatabaseFields.id] as int?,
    tagName: json[TagDatabaseFields.tagName] as String?,
    tagCreatedDate: json[TagDatabaseFields.tagCreatedDate] as String?,
    tagColor: json[TagDatabaseFields.tagColor] as String?
  );

  Map<String, Object?> toJson() => {
    TagDatabaseFields.id : id,
    TagDatabaseFields.tagName : tagName,
    TagDatabaseFields.tagCreatedDate : tagCreatedDate,
    TagDatabaseFields.tagColor : tagColor
  };

}