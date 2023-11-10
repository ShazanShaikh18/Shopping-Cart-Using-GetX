import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cart_app/Screens/cart_screen1.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import 'product_details_screen.dart';

class ProductListView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Product List',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'MyFont', fontSize: 22),
        ),
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
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 217, 237, 235),
        shape: ShapeBorder.lerp(Border.all(),
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(43)), 5),
        child: DrawerHeader(
            decoration: const BoxDecoration(),
            curve: Curves.bounceInOut,
            child: Container(
              color: const Color.fromARGB(255, 251, 253, 253),
              child: ListView(
                children: [
                  const UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        minRadius: 40,
                        backgroundImage: AssetImage('assets/images/my_pic.jpg'),
                      ),
                      accountName: Text(
                        'Shazan Shaikh',
                        style: TextStyle(fontSize: 19.5),
                      ),
                      accountEmail: Text(
                        'shazanshaikh143.ss@gmail.com',
                        style: TextStyle(fontSize: 16.5),
                      )),
                  const Divider(
                    thickness: 2,
                  ),
                  InkWell(
                    onTap: () => Get.to(const CartScreen()),
                    child: const ListTile(
                      leading: Icon(
                        Icons.shopping_cart_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                      title: Text(
                        'My Cart',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                ],
              ),
            )),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return FutureBuilder(
            future: checkInternetConnection(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == false) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons
                            .signal_wifi_statusbar_connected_no_internet_4_rounded,
                        size: 30),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'No Internet Connection!',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ));
              } else {
                return CarouselSlider.builder(
                  itemCount: productController.productList.length,
                  itemBuilder: (context, index, realIndex) {
                    final product = productController.productList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ProductDetailScreen(product: product));
                          },
                          child: Card(
                            color: Colors.grey.shade200,
                            margin: const EdgeInsets.all(15),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              height: 600,
                              width: 400,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: product.image.toString(),
                                    fit: BoxFit.fill,
                                  ),
                                  const Divider(),
                                  Text(
                                    product.title.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'MyFont',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Chip(
                                      backgroundColor: const Color.fromARGB(
                                          255, 203, 203, 203),
                                      label: Text(
                                        '\$  ${product.price}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    pauseAutoPlayOnTouch: true,
                    autoPlayCurve: Curves.bounceIn,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    height: 700,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                  ),
                );
              }
            },
          );
        }
      }),
    );
  }

  // Function to check internet connection
  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
