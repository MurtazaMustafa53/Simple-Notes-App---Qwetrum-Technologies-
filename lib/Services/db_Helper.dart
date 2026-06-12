import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:staticnotes/Model/noteModel.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        date TEXT NOT NULL,
        color INTEGER NOT NULL
      )
    ''');
  }

  Future<void> createNote(Note note) async {
    final db = await instance.database;

    await db.insert('notes', note.toMap());
  }

  Future<List<Note>> readAllNote() async {
    final db = await instance.database;

    final result = await db.query('notes', orderBy: 'date DESC');

    return result.map((map) => Note.fromMap(map)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;

    return await db.update(
      'notes',
      note.toMap(),
      where: 'id=?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(String id) async {
    final db = await instance.database;

    return await db.delete('notes', where: 'id=?', whereArgs: [id]);
  }
}
