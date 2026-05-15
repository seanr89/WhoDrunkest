import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pint_league.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        count INTEGER,
        drink_type TEXT,
        location TEXT,
        timestamp TEXT
      )
    ''');
  }

  // CRUD operations
  Future<int> insertLog(Map<String, dynamic> log) async {
    final db = await database;
    return await db.insert('logs', log);
  }

  Future<List<Map<String, dynamic>>> getLogs() async {
    final db = await database;
    return await db.query('logs', orderBy: 'timestamp DESC');
  }

  Future<int> deleteLog(int id) async {
    final db = await database;
    return await db.delete('logs', where: 'id = ?', whereArgs: [id]);
  }
}
