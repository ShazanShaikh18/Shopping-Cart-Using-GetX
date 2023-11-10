import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: 430,
                  color: Colors.black87,
                  child: Center(
                      child: Text(
                    'Amount: \$ ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                Positioned(
                  top: 55,
                  left: 5,
                  child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                        size: 32,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: ' eg. xyz@gmail.com',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 17)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Card information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'eg. 1234 1234 1234 1234',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(Icons.credit_card_outlined),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 100,
                          width: 195,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'MM / YY',
                                hintStyle: TextStyle(
                                    fontSize: 17, color: Colors.grey)),
                          )),
                      SizedBox(
                          height: 100,
                          width: 198,
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.credit_card),
                              border: OutlineInputBorder(),
                              hintText: 'CVC',
                              hintStyle:
                                  TextStyle(fontSize: 17, color: Colors.grey),
                            ),
                          ))
                    ],
                  ),
                  Text(
                    'Name on card',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'eg. Shazan',
                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'Country or region',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'India',
                        hintStyle: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ))),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ZIP',
                        hintStyle: TextStyle(fontSize: 17, color: Colors.grey)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      // Payment button
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enter valid information'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Colors.yellow.shade600,
          alignment: Alignment.center,
          height: 70.0,
          child: const Text(
            'Pay  \$',
            style: TextStyle(
              fontFamily: 'MyFont',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
