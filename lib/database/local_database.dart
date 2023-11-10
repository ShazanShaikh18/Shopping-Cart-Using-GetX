import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class LocalDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'localdata_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Localdata (
            id INTEGER PRIMARY KEY,
            title TEXT,
            image TEXT,
            price REAL
          )
        ''');
      },
    );
  }

  Future<void> insertLocalData({required String title, String? image, double price = 0.0}) async {
    final db = await database;
    await db.insert("Localdata", {"title": title, "image": image, "price": price});
  }

  Future<List<Map<String, dynamic>>> getLocalData() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query('Localdata');
    return data;
  }

  Future<void> deleteLocalData(int id) async {
    final db = await database;
    await db.delete(
      'Localdata',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

