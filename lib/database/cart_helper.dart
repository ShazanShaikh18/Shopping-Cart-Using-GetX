import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cart_app/model/product_model.dart';

class CartHelper {
  static const String cartKey = 'cart';

  Future<List<ProductModel>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartData = prefs.getString(cartKey);
    if (cartData != null) {
      List<dynamic> cartList = json.decode(cartData);
      List<ProductModel> cartItems =
          cartList.map((item) => ProductModel.fromJson(item)).toList();
      return cartItems;
    }
    return [];
  }

  Future<void> addToCart(ProductModel product) async {
    List<ProductModel> cartItems = await getCart();
    cartItems.add(product);
    saveCart(cartItems);
  }

  Future<void> removeFromCart(int id) async {
    List<ProductModel> cartItems = await getCart();
    cartItems.removeWhere((item) => item.id == id);
    saveCart(cartItems);
  }

  Future<void> saveCart(List<ProductModel> cartItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartData = json.encode(cartItems);
    await prefs.setString(cartKey, cartData);
  }
}