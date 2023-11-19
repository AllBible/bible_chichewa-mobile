import 'package:chichewa_bible/classes/highlight.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// https://docs.flutter.dev/cookbook/persistence/sqlite

class DatabaseHighlights {
  
  static const _tableName = "highlights";

  static Future<Database> _getDatabase() async {
    // Open the database and store the reference.
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'highlights.db'),

      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, book INTEGER, chapter INTEGER, verse INTEGER, start INTEGER, end INTEGER, color TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  static Future<int> insertHighlist(Highlight h) async {
    final db = await _getDatabase();
    return await db.insert(
      _tableName,
      h.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Highlight>> getHighlists(int book, int chapter) async {
    // Get a reference to the database.
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query(_tableName, where: 'book = ?', whereArgs: [book]);

    // Convert the List<Map<String, dynamic> into a List.
    return List.generate(maps.length, (i) {
      return Highlight.fromJson(maps[i]);
    }).where((element) => element.chapter == chapter).toList();
  }

  static Future<void> updateHighlight(int id, Highlight h) async {
    
    final db = await _getDatabase();
    await db.update(
      _tableName,
      h.toJson(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteHighlight(int id) async {
    // Get a reference to the database.
    final db = await _getDatabase();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
