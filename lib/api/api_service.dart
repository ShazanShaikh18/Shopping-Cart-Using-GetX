import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class ApiService {
  static var client = http.Client();

  static Future<List<ProductModel>?> fetchProducts() async {
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return producFromJson(jsonString);
    } else {
      return Get.defaultDialog(
          title: "API response failed!",
          content: Text("API doesn't give correct response"));
    }
  }
}
