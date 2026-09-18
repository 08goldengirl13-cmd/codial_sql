import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../Model/kurs.dart';
import '../../Model/mentor.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService.init();
  static Database? _database;

  DatabaseService.init();

  static const String tableKurslar = 'kurslar';
  static const String tableMentorlar = 'mentorlar';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, "kurs.db");
    return await openDatabase(path, version: 2, onCreate: _createTable, onUpgrade: _onUpgrade);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS kurslar');
      await db.execute('DROP TABLE IF EXISTS mentorlar');
      await _createTable(db, newVersion);
    }
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableKurslar (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nomi TEXT NOT NULL,
          kurs_haqida TEXT NOT NULL,
          tarif TEXT DEFAULT ' '
      );
    ''');

    await db.execute('''
    CREATE TABLE $tableMentorlar (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ism TEXT NOT NULL,
        familya TEXT NOT NULL,
        raqam TEXT NOT NULL,
        kurs_id INTEGER NOT NULL,
        FOREIGN KEY (kurs_id) REFERENCES $tableKurslar (id) ON DELETE CASCADE
    );
    ''');
  }

  // 1. Kurs qo'shish (CREATE)
  Future<int> insertKurs(Kurs kurs) async {
    final db = await instance.database;
    return await db.insert(
      tableKurslar,
      kurs.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 2. Barcha kurslarni o'qib olish (READ)
  Future<List<Kurs>> getKurslar() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableKurslar);
    return List.generate(maps.length, (i) => Kurs.fromJson(maps[i]));
  }

  // 3. Kursni tahrirlash (UPDATE)
  Future<int> updateKurs(Kurs kurs) async {
    final db = await instance.database;
    return await db.update(
      tableKurslar,
      kurs.toMap(),
      where: 'id = ?',
      whereArgs: [kurs.id],
    );
  }

  // 4. Kursni o'chirish (DELETE)
  Future<int> deleteKurs(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableKurslar,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 1. Yangi mentor qo'shish (CREATE)
  Future<int> insertMentor(Mentors mentor) async {
    final db = await instance.database;
    return await db.insert(
      tableMentorlar,
      mentor.ToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 2. Barcha mentorlarni o'qib olish (READ)
  Future<List<Mentors>> getMentors() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableMentorlar);
    return List.generate(maps.length, (i) => Mentors.fromJson(maps[i]));
  }

  // 3. Muallif/Mentorni tahrirlash (UPDATE)
  Future<int> updateMentor(Mentors mentor) async {
    final db = await instance.database;
    return await db.update(
      tableMentorlar,
      mentor.ToMap(),
      where: 'id = ?',
      whereArgs: [mentor.id],
    );
  }

  // 4. Mentorni o'chirish (DELETE)
  Future<int> deleteMentor(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableMentorlar,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 5. Muayyan bir kursga tegishli mentorlarni o'qib olish (BONUS)
  Future<List<Mentors>> getMentorsByKursId(int kursId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableMentorlar,
      where: 'kurs_id = ?',
      whereArgs: [kursId],
    );
    return List.generate(maps.length, (i) => Mentors.fromJson(maps[i]));
  }
}
