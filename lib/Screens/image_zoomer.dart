import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../model/product_model.dart';

class ImageZoomer extends StatelessWidget {
  final ProductModel product;

  const ImageZoomer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(product.image.toString()),
        minScale: 0.1,
        maxScale: 10.0,
      ),
    );
  }
}
