import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:onboarding_app/data/models/book_model.dart';

class BookLocalDataSource {
  static final BookLocalDataSource _instance = BookLocalDataSource._();
  static Database? _database;

  BookLocalDataSource._();

  factory BookLocalDataSource() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'books.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            author TEXT,
            year INTEGER,
            description TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertBook(BookModel book) async {
    final db = await database;
    return await db.insert('books', book.toMap());
  }

  Future<List<BookModel>> getBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) => BookModel.fromMap(maps[i]));
  }

  Future<int> deleteBook(int id) async {
    final db = await database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }
}