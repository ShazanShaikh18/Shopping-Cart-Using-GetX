import 'package:cart_app/model/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {

  //var myCartList = <ProductModel>[].obs;
  // RxList<ProductModel> myCartList = <ProductModel>[].obs;

  RxList<Map<String, dynamic>> localCartProductList =
      <Map<String, dynamic>>[].obs;

//   Rx<ProductModel> productModel = ProductModel().obs;

  void increaseQuantity(ProductModel productModel) {
    productModel.quantity++;
    print(productModel.quantity);
    //localCartProductList.refresh();
  }

  void decreaseQuantity(ProductModel productModel) {
    if (productModel.quantity > 0) {
      productModel.quantity--;
      print(productModel.quantity);
      //localCartProductList.refresh();
    }
  }
}
