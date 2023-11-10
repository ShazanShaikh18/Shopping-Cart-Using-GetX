// import 'package:cart_app/database/database_helper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../model/product_model.dart';
// import '../main.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           title: const Text('My Cart'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//                 child: Obx(
//               () => ListView.builder(
//                 itemBuilder: (context, index) {
//                   var data = myCartList[index];
//                   return CartItem(
//                     product: data,
//                   );
//                 },
//                 itemCount: myCartList.length,
//               ),
//             )),
//             Text(
//               'Total items: ' + myCartList.length.toString(),
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//             ),
//             // Text('Total Amount: ' + ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: GestureDetector(
//                 child: Container(
//                   height: 60,
//                   width: 200,
//                   decoration: BoxDecoration(
//                       border: Border.all(),
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.black),
//                   child: const Center(
//                     child: Text(
//                       'Proceed to buy',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ));
//   }
// }

// class CartItem extends StatefulWidget {
//   final ProductModel product;
//   const CartItem({super.key, required this.product});

//   @override
//   State<CartItem> createState() => _CartItemState();
// }

// class _CartItemState extends State<CartItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 margin: const EdgeInsets.all(10),
//                 elevation: 3,
//                 color: Colors.grey.shade300,
//                 child: ListTile(
//                   leading: Image.network(widget.product.image.toString()),
//                   title: Text(widget.product.title.toString(),
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 20)),
//                   subtitle: Text(
//                     '\$ ' + widget.product.price.toString(),
//                     style: const TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//                 onPressed: () {
//                   setState(() {
//                     widget.product.quantity++ *
//                         widget.product.price!.toDouble();
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.add_circle_outline,
//                   size: 33,
//                 )),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Container(
//                 height: 40,
//                 width: 100,
//                 color: Colors.black,
//                 child: Center(
//                   child: Text(
//                     'Quantity : ${widget.product.quantity}',
//                     style: const TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(
//                 onPressed: () {
//                   setState(() {
//                     if (widget.product.quantity > 0) {
//                       widget.product.quantity--;
//                     }
//                   });
//                 },
//                 icon: const Icon(
//                   CupertinoIcons.minus_circled,
//                   size: 33,
//                 )),
//             const SizedBox(
//               width: 30,
//             ),
            
//             ElevatedButton.icon(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text('Are you sure you want to remove this item?'),
//                       actions: [
//                         ElevatedButton(
//                             style: const ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStatePropertyAll(Colors.red)),
//                             onPressed: () async {
//                               //await DatabaseHelper.deleteToCart();
//                             },
//                             child: const Text(
//                               'Yes',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 17),
//                             )),
//                         ElevatedButton(
//                             onPressed: () {
//                               Get.back();
//                             },
//                             child: const Text(
//                               'No',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 17),
//                             ))
//                       ],
//                     );
//                   },
//                 );
//               },
//               icon: const Icon(
//                 Icons.delete_forever,
//                 color: Colors.black,
//               ),
//               label: const Text(
//                 'Remove',
//                 style:
//                     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               ),
//               style: ButtonStyle(
//                   elevation: const MaterialStatePropertyAll(4),
//                   backgroundColor:
//                       MaterialStatePropertyAll(Colors.grey.shade200)),
//             )
//           ],
//         ),
//         const Divider(),
//         const Text(
//           'Total Amount: ',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Text(
//           '\$ '
//           '${widget.product.quantity * widget.product.price!.toDouble()}',
//           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         const Divider(
//           thickness: 2,
//         ),
//       ],
//     );
//   }
// }
