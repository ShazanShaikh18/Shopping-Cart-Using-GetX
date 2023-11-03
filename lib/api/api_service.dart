import 'package:cart_app/Model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  
  static var client = http.Client();

  static Future<List<ProductModel>?> fetchProducts() async {
    var response = await client.get('https://fakestoreapi.com/products' as Uri);

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return producFromJson(jsonString);
    }
    else{
      return null;
    }
  }
}