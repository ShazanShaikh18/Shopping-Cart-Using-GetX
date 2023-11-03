import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class ProductListView extends StatelessWidget {
final ProductController productController = Get.put(ProductController());

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Home Screen'),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator(),);
        }
        else{
          return ListView.builder(
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              return Column(children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: 150,
                      height: 100,
                      margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          productController.productList[index].image.toString(),
                          width: 150,
                          height: 100,
                          fit: BoxFit.fill,
                          color: Colors.purple,
                          colorBlendMode: BlendMode.color,
                        ),
                      ),
                    ),

                    Flexible(child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productController.productList[index].title.toString()),
                        Text(productController.productList[index].description.toString()),
                        Text(productController.productList[index].category.toString()),
                      ],
                    ))
                  ],
                ),
                Container(color: Colors.grey,
                height: 2),
              ],);
            },);
        }
      })
    );
  }
}
