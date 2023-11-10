import 'package:cart_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Cart.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE ProductModel(id INTEGER PRIMARY KEY, price DOUBLE PRIMARY KEY, title TEXT NOT NULL, image TEXT NOT NULL);"),
        version: _version);
  }

  static Future<int> addToCart(
    ProductModel productModel,
  ) async {
    final db = await _getDb();
    return await db.insert("ProductModel", productModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateToCart(ProductModel productModel) async {
    final db = await _getDb();
    return await db.update("ProductModel", productModel.toJson(),
        where: 'id = ?',
        whereArgs: [productModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteToCart(id) async {
    final db = await _getDb();
    return await db.delete("ProductModel", where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<ProductModel>?> getAllProduct() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query("ProductModel");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => ProductModel.fromJson(maps[index]));
  }

  getCartItems() {}

  removeFromCart(int productId) {}
}
