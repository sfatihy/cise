import 'package:cise/database/userDatabaseFields.dart';

class User {

  int? id;
  String? userName;
  String? motherLanguage;
  String? foreignLanguage;

  User({
    this.id,
    required this.userName,
    required this.motherLanguage,
    required this.foreignLanguage
  });

  User copy({
    int? id,
    String? userName,
    String? motherLanguage,
    String? foreignLanguage
  }) => User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      motherLanguage: motherLanguage ?? this.motherLanguage,
      foreignLanguage: foreignLanguage ?? this.foreignLanguage
  );

  static User fromJson(Map<String, Object?> json) => User(
      id: json[UserDatabaseFields.id] as int?,
      userName: json[UserDatabaseFields.userName] as String?,
      motherLanguage: json[UserDatabaseFields.motherLanguage] as String?,
      foreignLanguage: json[UserDatabaseFields.foreignLanguage] as String?
  );

  Map<String, Object?> toJson() => {
    UserDatabaseFields.id : id,
    UserDatabaseFields.userName : userName,
    UserDatabaseFields.motherLanguage : motherLanguage,
    UserDatabaseFields.foreignLanguage : foreignLanguage
  };

}