import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BookmarkDB {
  static Database? _db;

  static Future<Database> _getDB() async {
    if (_db != null) return _db!;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'bookmarks.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookmarks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            book TEXT,
            chapter INTEGER,
            verse INTEGER,
            text TEXT,
            color TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE bookmarks ADD COLUMN color TEXT');
        }
      },
    );
    return _db!;
  }

  static Future<void> addBookmark(
      String book, int chapter, int verse, String text, String color) async {
    final db = await _getDB();

    final existing = await db.query(
      'bookmarks',
      where: 'book = ? AND chapter = ? AND verse = ?',
      whereArgs: [book, chapter, verse],
    );

    if (existing.isNotEmpty) {
      await db.update(
        'bookmarks',
        {'color': color},
        where: 'book = ? AND chapter = ? AND verse = ?',
        whereArgs: [book, chapter, verse],
      );
    } else {
      await db.insert(
        'bookmarks',
        {
          'book': book,
          'chapter': chapter,
          'verse': verse,
          'text': text,
          'color': color,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  static Future<void> removeBookmark(String book, int chapter, int verse) async {
    final db = await _getDB();
    await db.delete(
      'bookmarks',
      where: 'book = ? AND chapter = ? AND verse = ?',
      whereArgs: [book, chapter, verse],
    );
  }

  static Future<List<Map<String, dynamic>>> getAllBookmarks() async {
    final db = await _getDB();
    return db.query('bookmarks', orderBy: 'book, chapter, verse');
  }

  static Future<Map<int, String>> getBookmarks(String book, int chapter) async {
    final db = await _getDB();
    final result = await db.query(
      'bookmarks',
      where: 'book = ? AND chapter = ?',
      whereArgs: [book, chapter],
    );

    return {
      for (var row in result)
        (row['verse'] as int): (row['color'] ?? 'yellow') as String
    };
  }

  static Future<void> deleteBookmark(int id) async {
    final db = await _getDB();
    await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> clearAll() async {
    final db = await _getDB();
    await db.delete('bookmarks');
  }
}
