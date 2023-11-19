import 'package:chichewa_bible/classes/comment.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// https://docs.flutter.dev/cookbook/persistence/sqlite

class DatabaseComments {
  static const _tableComment = "comments";

  static Future<Database> _getDatabase() async {
    // Open the database and store the reference.
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'comments.db'),

      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE $_tableComment(id INTEGER PRIMARY KEY, title TEXT, comment TEXT, book INTEGER, chapter INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  static Future<int> insertComment(Comment comment) async {
    final db = await _getDatabase();
    return await db.insert(
      _tableComment,
      comment.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Comment?> getCommentFrom(int book, int chapter) async {
    // Get a reference to the database.
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query(_tableComment, where: 'book = ?', whereArgs: [book]);

    // Convert the List<Map<String, dynamic> into a List.
    return List.generate(maps.length, (i) {
      return Comment.fromJson(maps[i]);
    }).firstWhereOrNull((element) => element.chapter == chapter);
  }

  static Future<void> updateComment(Comment comment) async {
    // Get a reference to the database.
    final db = await _getDatabase();

    // Update the given Dog.
    await db.update(
      _tableComment,
      comment.toJson(),
      where: 'id = ?',
      whereArgs: [comment.id],
    );
  }

  static Future<void> deleteComment(int id) async {
    // Get a reference to the database.
    final db = await _getDatabase();
    await db.delete(
      _tableComment,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
