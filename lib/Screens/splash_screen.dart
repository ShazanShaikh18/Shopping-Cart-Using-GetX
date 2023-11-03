import 'dart:async';

import 'package:cart_app/Screens/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 3500), () {
      Get.off(ProductListView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              Image.asset('assets/images/cart_image.png'),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Cart App',
                style: TextStyle(
                    fontFamily: 'MyFont',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.red, offset: Offset(2, 1.5))]),
              ),
              const SizedBox(
                height: 40,
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Created by:  SHAZAN SHAIKH',
                  style: TextStyle(
                      fontFamily: 'MyFont',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
