import 'package:cise/database/tagDatabaseFields.dart';
import 'package:cise/database/tagDatabaseModel.dart';
import 'package:cise/database/userDatabaseFields.dart';
import 'package:cise/database/userDatabaseModel.dart';
import 'package:cise/database/wordDatabaseFields.dart';
import 'package:cise/database/wordDatabaseModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// sqlite file is here -> data/data/app_package_name/databases
class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async{

    if(_database != null) return _database!;

    _database = await _initDB("wordDatabase.db");

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableUser(
      ${UserDatabaseFields.id} $idType,
      ${UserDatabaseFields.userName} $textType,
      ${UserDatabaseFields.motherLanguage} $textType,
      ${UserDatabaseFields.foreignLanguage} $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableTag(
      ${TagDatabaseFields.id} $idType,
      ${TagDatabaseFields.tagName} $textType,
      ${TagDatabaseFields.tagCreatedDate} $textType,
      ${TagDatabaseFields.tagColor} $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableWord(
      ${WordDatabaseFields.id} $idType,
      ${WordDatabaseFields.word} $textType,
      ${WordDatabaseFields.wordTranslated} $textType,
      ${WordDatabaseFields.sentence} $textType,
      ${WordDatabaseFields.sentenceTranslated} $textType,
      ${WordDatabaseFields.source} $textType,
      ${WordDatabaseFields.destination} $textType,
      ${WordDatabaseFields.wordAddedDate} $textType,
      ${WordDatabaseFields.wordMemorizedDate} $textType,
      ${WordDatabaseFields.isMemorized} $integerType,
      ${WordDatabaseFields.tagId} $integerType,
      FOREIGN KEY (${WordDatabaseFields.tagId}) REFERENCES $tableTag(${TagDatabaseFields.id})
    )
    ''');

    Tag tag = Tag(
      id: 0,
      tagName: "All",
      tagCreatedDate: DateTime.now().microsecondsSinceEpoch.toString(),
      tagColor: "0xFFFFFFFF"
    );

    createTag(tag);

  }

  // CREATE
  Future<Word> createWord(Word word) async {

    final db = await instance.database;

    final id = await db.insert(tableWord, word.toJson());

    return word.copy(id: id);
  }

  Future<Tag> createTag(Tag tag) async {
    final db = await instance.database;

    final id = await db.insert(tableTag, tag.toJson());

    return tag.copy(id: id);
  }

  Future<User> createUser(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUser, user.toJson());

    return user.copy(id: id);
  }

  // READ
  Future<Word> readWord(int id) async {

    final db = await instance.database;

    final maps = await db.query(
      tableWord,
      columns: WordDatabaseFields.values,
      where: '${WordDatabaseFields.id} = ?',
      whereArgs: [id]
    );

    return Word.fromJson(maps.first);
  }

  Future<List<Word>> readAllWord() async {
    final db = await instance.database;

    final result = await db.query(
        tableWord,
        orderBy: '${WordDatabaseFields.id} DESC'
    );

    return result.map((json) => Word.fromJson(json)).toList();
  }

  Future<List<Word>> readAllWordWithTagFilter(int filterTagId) async {
    final db = await instance.database;

    if (filterTagId == 0) {
      final result = await db.query(
        tableWord,
        orderBy: '${WordDatabaseFields.id} DESC'
      );
      return result.map((json) => Word.fromJson(json)).toList();
    }
    else if (filterTagId == -1) {
      final result = await db.query(
        tableWord,
        where: '${WordDatabaseFields.isMemorized} = ?',
        whereArgs: [1],
        orderBy: '${WordDatabaseFields.id} DESC'
      );
      return result.map((json) => Word.fromJson(json)).toList();
    }
    else if (filterTagId == -2) {
      final result = await db.query(
          tableWord,
          where: '${WordDatabaseFields.isMemorized} = ?',
          whereArgs: [0],
          orderBy: '${WordDatabaseFields.id} DESC'
      );
      return result.map((json) => Word.fromJson(json)).toList();
    }
    else {
      final result = await db.query(tableWord,
        where: '${WordDatabaseFields.tagId} = ?',
        whereArgs: [filterTagId]
      );
      return result.map((json) => Word.fromJson(json)).toList();
    }
  }

  Future<List<Tag>> readAllTag() async {
    final db = await instance.database;

    final result = await db.query(
        tableTag,
        orderBy: '${TagDatabaseFields.id} DESC'
    );

    return result.map((json) => Tag.fromJson(json)).toList();
  }

  Future readAllWordWithTag(int id) async {
    final db = await instance.database;

    final data = await db.rawQuery('''
      SELECT $tableWord.${WordDatabaseFields.id}, $tableTag.${TagDatabaseFields.tagName} FROM $tableWord
      LEFT JOIN $tableTag ON
        $tableWord.${WordDatabaseFields.tagId} = $tableTag.${TagDatabaseFields.id}
      WHERE $tableWord.${WordDatabaseFields.id} = $id
    ''');

    print(data.first["tagName"]);

    return data.first;
  }

  Future<List<Word>> readAllMemorizedWord() async {
    final db = await instance.database;

    final result = await db.query(
      tableWord,
      where: '${WordDatabaseFields.isMemorized} = ?',
      whereArgs: [1]
    );

    return result.map((json) => Word.fromJson(json)).toList();
  }

  Future<List> readAllUser() async {
    final db = await instance.database;

    final result = await db.query(
      tableUser,
      columns: UserDatabaseFields.values,
    );

    return result.map((json) => User.fromJson(json)).toList();
  }

  // UPDATE
  Future updateWord(Word word) async {
    final db = await instance.database;

    db.update(
      tableWord,
      word.toJson(),
      where: '${WordDatabaseFields.id} = ?',
      whereArgs: [word.id]
    );
  }

  Future updateWordMemorized(int id, int data) async {
    final db = await instance.database;

    final now = DateTime.now().microsecondsSinceEpoch.toString();

    db.rawUpdate('''
    UPDATE $tableWord
    SET ${WordDatabaseFields.isMemorized} = $data,
    ${WordDatabaseFields.wordMemorizedDate} = $now
    WHERE ${WordDatabaseFields.id} = $id
    ''');
  }

  Future updateTag(Tag tag) async {
    final db = await instance.database;

    db.update(
      tableTag,
      tag.toJson(),
      where: '${TagDatabaseFields.id} = ?',
      whereArgs: [tag.id]
    );
  }

  Future updateUser(User user) async {
    final db = await instance.database;

    db.update(
      tableUser,
      user.toJson(),
      where: '${UserDatabaseFields.id} = ?',
      whereArgs: [user.id]
    );
  }

  // DELETE
  Future deleteWord(int id) async {
    final db = await instance.database;

    db.delete(
      tableWord,
      where: '${WordDatabaseFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future deleteTag(int id) async {
    final db = await instance.database;

    db.rawUpdate('''
      UPDATE $tableWord
      SET ${WordDatabaseFields.tagId} = 0
      WHERE ${WordDatabaseFields.tagId} = $id
      '''
    );

    db.delete(
      tableTag,
      where: '${TagDatabaseFields.id} = ?',
      whereArgs: [id]
    );
  }

}