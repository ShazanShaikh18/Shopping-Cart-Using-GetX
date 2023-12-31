import 'package:cart_app/Screens/payment_screen.dart';
import 'package:cart_app/Screens/product_list_view.dart';
import 'package:cart_app/main.dart';
import 'package:cart_app/screens/image_zoomer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/database_helper.dart';
import '../model/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    LocalDataBase().getDataLocally();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Row(
            children: [
              SizedBox(width: 90),
              Text('My Cart',
                  style: TextStyle(fontFamily: 'MyFont', fontSize: 22)),
              SizedBox(
                width: 10,
              ),
              Icon(CupertinoIcons.shopping_cart)
            ],
          ),
        ),
        // Proceed to pay button
        bottomNavigationBar: InkWell(
          onTap: () {
            Get.to(PaymentScreen());

            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('Payment mode not added'),
            //     duration: Duration(seconds: 2),
            //   ),
            // );
          },
          child: Container(
            color: Colors.yellow.shade600,
            alignment: Alignment.center,
            height: 70.0,
            child: const Text(
              'Proceed to Pay',
              style: TextStyle(
                fontFamily: 'MyFont',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                // ignore: invalid_use_of_protected_member
                child: Obx(() => localCartProductList.value.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'No items availabe in your cart.',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.offAll(ProductListView());
                              },
                              child: const Text(
                                'Explore Home Page',
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      )
                    : ListView.builder(
                        // ignore: invalid_use_of_protected_member
                        itemCount: localCartProductList.value.length,
                        itemBuilder: (context, index) {
                          // ignore: invalid_use_of_protected_member
                          var data = localCartProductList.value[index];

                          return Column(
                            children: [
                              CartItem(
                                product: ProductModel(
                                  price: data['price'],
                                  image: data['image'],
                                  title: data['title'],
                                  id: data['id'],
                                  quantity: data['quantity'] ?? 0,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                      )),
              ),
            ],
          ),
        ));
  }
}

class CartItem extends StatefulWidget {
  final ProductModel product;

  CartItem({Key? key, required this.product}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: const EdgeInsets.all(10),
                elevation: 3,
                color: Colors.grey.shade300,
                child: ListTile(
                  leading: InkWell(
                      onTap: () => Get.to(ImageZoomer(product: widget.product)),
                      child: Image.network(widget.product.image.toString())),
                  title: Text(widget.product.title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Text(
                    '\$ ${widget.product.price}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  int quantity = widget.product.quantity;
                  print("----before----${quantity}");
                  quantity++;
                  print("----after----${quantity}");
                  LocalDataBase().updateQuantity(widget.product.id, quantity);
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 33,
                ),
                tooltip: 'Add'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 40,
                width: 100,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Quantity : ${widget.product.quantity}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  if (widget.product.quantity > 0) {
                    int quantity = widget.product.quantity;
                    print("----before----${quantity}");
                    quantity--;
                    print("----after----${quantity}");

                    LocalDataBase().updateQuantity(widget.product.id, quantity);
                  }
                },
                icon: const Icon(
                  CupertinoIcons.minus_circled,
                  size: 33,
                ),
                tooltip: 'Remove'),
            const SizedBox(
              width: 30,
            ),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          'Are you sure you want to remove this item?'),
                      actions: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () async {
                              LocalDataBase localDataBase = LocalDataBase();
                              int productId = widget.product.id;

                              await localDataBase
                                  .deleteDataLocally(productId)
                                  .then((value) {
                                Get.back();
                              });
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ))
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.black,
              ),
              label: const Text(
                'Remove',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(4),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.grey.shade200)),
            )
          ],
        ),
        const Divider(),
        const Text(
          'Total Amount: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '\$ '
          '${widget.product.quantity * widget.product.price!.toDouble()}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
