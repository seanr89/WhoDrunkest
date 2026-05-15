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

    await db.execute('''
      CREATE TABLE performers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        status TEXT,
        score INTEGER,
        trend TEXT,
        trend_score TEXT,
        img_url TEXT,
        is_user INTEGER DEFAULT 0
      )
    ''');

    await _seedPerformers(db);
  }

  Future<void> _seedPerformers(Database db) async {
    final List<Map<String, dynamic>> performers = [
      {
        'name': 'James Miller',
        'status': 'The Brewmaster',
        'score': 22,
        'trend': 'up',
        'trend_score': '2',
        'img_url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAxYm1Io9E4egxe-bLNXG3NBCrTIftnum8eb8EKIpw-bMOzS1AVs8WsbaA3lBRMuSlIR7ELUHDvM2eW6SbXVTyUkmu67VEz62rg-ghXb4XHpSjfRmAYP0znD4EoWDEnBATLZNBn_ESVSEm7L9EQsGs8FCIdK8JL02HzbJCZZBe0HSMN2aEyxnmitrzge299IfNs5gvPPcTZ29YU1sv1OvgsypkeaUe2yh5iJhn_9TrMI_t9_zqDJXeAZv1-SoMi_axvddGud0wSpeF_',
        'is_user': 0
      },
      {
        'name': 'Sarah Chen',
        'status': 'Craft Enthusiast',
        'score': 19,
        'trend': 'flat',
        'trend_score': '0',
        'img_url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCMQ42nGwZaeHgf-eZfpkRBWVmUPk0CtNIFbgSc3kdjqGluB6UE1DvpVTgGYhgGZtk10443xu6jJ3arH9oHRBo_q5xIKIZqBcSIgIwcM8xsHUoqGepDz6jdO7om7C9bFpWflIuD9TUbXaotij2qlZbxdIpypS7HwwYUDKr2VwRpebL09kc7yNnxA5GpwjZT1nISjNZpNEYtpK9RJc3Q9RumpOIba-X860F5TdLsioS-pc9qV7Gf16H-CXa6v45J2W8wnlemqNHFRZCa',
        'is_user': 0
      },
      {
        'name': 'Marcus Thorne',
        'status': 'Social Legend',
        'score': 17,
        'trend': 'down',
        'trend_score': '1',
        'img_url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDR0j_pnjFNZPg8iXGBVChyqgxbNR0Gyy-dAzwCtTy2-XgvKt4LVoYbL--k410WcxXW2xqjG0VZKMPLQcni3r3FwjOiJihmjY_tvney3y7Zd-46FtBpSWu9J_VSL-rP5ge7buEejMLWZtzstmkKSH8sGwVyohogQ4u-UyzSC95XtFlcTXB7ILkcrjgIcb79vF5aKslQum3Ybs9QOgDcu0kJkxdsqOXlN4tziciCBhVzz97x3MoDa6KacYrXXo_4iIw0fHcVmjexvOGU',
        'is_user': 0
      },
      {
        'name': 'Liam O\'Neill',
        'status': 'Stout Specialist',
        'score': 12,
        'trend': 'flat',
        'trend_score': '0',
        'img_url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAQ32xFG_BkqxYFdMPcgwMgYQcv7RPgC7njhjU-EUnGP4KdGSfW2OWhk_eggNwPTTpvos6UXtraaK2zCmKjrYEmcWy6LBUwqXWdo_cnHkkCbdZxfZylz4zEMJSHCl8w3m17CYbom97Rj5Ii-qW3KoY9hJRFkJrWdrNu37N3WMIlyvw46t9eXuNao3JIhsY62rzUQBD-iczMnOHEgY9s0BHBnzsJWUQVNBK_SjE0cgPEyTiPcDPPy6pgKT3WJjO04JPg3KIcF0l4NBto',
        'is_user': 0
      },
    ];

    for (var performer in performers) {
      await db.insert('performers', performer);
    }
  }

  Future<List<Map<String, dynamic>>> getPerformers() async {
    final db = await database;
    return await db.query('performers', orderBy: 'score DESC');
  }

  Future<int> getUserWeeklyPints() async {
    final db = await database;
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartStr = weekStart.toIso8601String().split('T')[0];
    
    final result = await db.rawQuery(
      'SELECT SUM(count) as total FROM logs WHERE timestamp >= ?',
      [weekStartStr]
    );
    
    return (result.first['total'] as num?)?.toInt() ?? 0;
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
