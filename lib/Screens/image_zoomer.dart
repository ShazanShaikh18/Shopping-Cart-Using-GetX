import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../model/product_model.dart';

class ImageZoomer extends StatelessWidget {
  final ProductModel product;

  const ImageZoomer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(product.image.toString()),
            minScale: 0.1,
            maxScale: 10.0,
          ),
          Positioned(
            top: 75,
            left: 5,
            child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                  size: 35,
                ),
                tooltip: 'Back'),
          )
        ],
      ),
    );
  }
}
