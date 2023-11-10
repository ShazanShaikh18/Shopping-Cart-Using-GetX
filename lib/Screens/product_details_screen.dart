import 'package:cart_app/Screens/cart_screen1.dart';
import 'package:cart_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../database/new_helper.dart';
import '../main.dart';
import 'image_zoomer.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(widget.product.category.toString()),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
                onPressed: () {
                  Get.to(const CartScreen());
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 28,
                  color: Color.fromARGB(255, 186, 228, 224),
                ),
                tooltip: 'My Cart'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(ImageZoomer(product: widget.product));
                  },
                  child: SizedBox(
                      height: 400,
                      child: Image.network(widget.product.image.toString())),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.product.title.toString(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Chip(
                    label: Text(
                  '\$ ${widget.product.price}',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                )),
                const Divider(),
                Text(widget.product.description.toString()),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmoothStarRating(
                      rating: widget.product.rating!.rate!.toDouble(),
                      size: 40,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                      allowHalfRating: true,
                      spacing: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('( ${widget.product.rating!.count} )'),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: GestureDetector(
                      onTap: () async {
                        if (myCartList.contains(widget.product)) {
                          // Product is already in the cart, show a snackbar
                          Get.snackbar(
                            'Error',
                            'This Product is already in your cart',
                            titleText: const Text(
                              'Alert!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            messageText: const Text(
                              'This Product is already in your cart',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            shouldIconPulse: true,
                            backgroundGradient: LinearGradient(
                                colors: [Colors.teal.shade500, Colors.cyan]),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.black54,
                            borderWidth: 2,
                            borderColor: Colors.black,
                            animationDuration: const Duration(seconds: 1),
                            icon: const Icon(Icons.error, color: Colors.black),
                            duration: const Duration(seconds: 3),
                            margin: const EdgeInsets.all(10),
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                          );
                        } else {
                          // Product is not in the cart, add it to the cart
                          myCartList.add(widget.product);
                          await LocalDataBase().addDataLocally(
                            title: widget.product.title.toString(),
                            image: widget.product.image.toString(),
                            price: widget.product.price!,
                            id: widget.product.id,
                          );
                          Get.to(const CartScreen());
                        }
                      },
                      child: Container(
                        height: 70,
                        //width: 100,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Add to cart',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(width: 15),
                              const Divider(),
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 30,
                                color: Colors.cyan.shade100,
                              )
                            ],
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
