import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model/product_model.dart';
import 'screens/splash_screen.dart';

RxList<ProductModel> myCartList = <ProductModel>[].obs;

RxList<Map<String, dynamic>> localCartProductList =
    <Map<String, dynamic>>[].obs;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
