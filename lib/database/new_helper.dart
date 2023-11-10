import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../main.dart';

Database? _database;

class LocalDataBase {
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDB('Local.db');
    return _database!;
  }

  Future _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE Localdata (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    image TEXT NOT NULL,
    price REAL,
        quantity INTEGER NOT NULL

  )
''');
  }

  Future updateQuantity(int id, int newQuantity) async {
    final db = await database;

    await db.rawUpdate('''
    UPDATE Localdata
    SET quantity = ?
    WHERE id = ?
  ''', [newQuantity, id]);
    getDataLocally();
  }

  // Future addDataLocally({title, image, price}) async {
  //   final db = await database;
  //   await db.insert("Localdata", {"title": title});
  //   print(
  //       'Title: ${title} And Image: ${image} And Price: ${price} Added to database successfully');
  //   // getDataLocally();
  //   return 'Added';
  // }

  Future<void> addDataLocally({
    required String title,
    required String image,
    double price = 0.0,
    int quantity = 0,
    required int id,
  }) async {
    final db = await database;
    await db.insert("Localdata", {
      "id": id,
      "title": title,
      "image": image,
      "price": price,
      "quantity": quantity
    });
    getDataLocally();
  }

  Future getDataLocally() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query('Localdata');
    localCartProductList.value = data;
    localCartProductList.refresh();
    print("-----data-----$data");
  }

  Future<void> deleteDataLocally(int id) async {
    final db = await database;
    await db.delete("Localdata", where: 'id = ?', whereArgs: [id]);
    getDataLocally();
    return print('Data Deleted Successfully!');
  }

  // Future readalldata() async {
  //   final db = await database;
  //   final alldata = await db.query("Localdata");
  //   WholeDataList = alldata;
  //   print(WholeDataList);
  //   return 'Successfully Read';
  // }
}
