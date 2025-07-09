import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/common/hiveobject/cart_item_model.dart';
import 'package:ecommerce/common/widgets/success_message_dialoge.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/checkout/model/checkout_model.dart';
import 'package:ecommerce/features/home/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

class Checkout extends StatefulWidget {
  final List<CartItemModel> item;
  const Checkout({super.key, required this.item});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _userBox = Hive.box<UserModel>("userDetailsHiveBox");
  final double deliveryCharge = 150;
  String selectedPayment = "CashOnDelivery";
  bool isSubmitting = false;

  // get total amount
  double getTotalAmount() {
    return widget.item
        .map((item) => (item.itemCount ?? 1) * (item.price ?? 0.0))
        .fold(0.0, (items, price) => items + price);
  }

  String getAllItemNamesAsString() {
    return widget.item.map((item) => item.name ?? '').join(', ');
  }

  // handel placeorder submit
  Future handelPlaceOrder() async {
    try {
      if (selectedPayment == "CashOnDelivery") {
        setState(() {
          isSubmitting = true;
        });
        final addtoorder = CheckoutModel(
          userId: _userBox.get("userDetails")?.sId,
          userEmail: _userBox.get("userDetails")?.email,
          userName: _userBox.get("userDetails")?.userName,
          dressName: getAllItemNamesAsString().toString(),
          status: "Pending",
          totalPrice: getTotalAmount().toInt(),
          quantity: widget.item.length,
        );

        final res = await http.post(
          Uri.parse("https://fashion-fusion-suneel.vercel.app/api/order"),
          headers: <String, String>{'Context-Type': 'application/json'},
          body: jsonEncode(addtoorder),
        );

        if (res.statusCode == 200) {
          if (mounted) {
            setState(() {
              isSubmitting = false;
            });
            // ignore: use_build_context_synchronously
            showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) => SuccessMessageDialoge(
                price: getTotalAmount().toString(),
                method: selectedPayment,
              ),
            );
            Timer(Duration(seconds: 2), () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
                (route) => false,
              );
            });
          }
        } else {
          if (mounted) {
            setState(() {
              isSubmitting = false;
            });
            ScaffoldMessenger.of(
              // ignore: use_build_context_synchronously
              context,
            ).showSnackBar(
              SnackBar(
                duration: Durations.long2,
                backgroundColor: Colors.red,
                content: Text("Error placing Order please try again!"),
              ),
            );
          }
        }
      } else {
        debugPrint("Payment through esewa");
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text("Error $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    "Shipping address ",
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 220, 220, 220),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                style: TextStyle(fontWeight: FontWeight.w500),
                                "Suneel Shrestha",
                              ),
                              Text(
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 230, 99, 72),
                                  fontWeight: FontWeight.w500,
                                ),
                                "Change",
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text("Ekantakuna, Lalitpur"),
                          Text("Chiya Addada"),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    "Payment Methods ",
                  ),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPayment = "Esewa";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedPayment == "Esewa"
                            ? const Color.fromARGB(255, 227, 227, 227)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  height: 30,
                                  width: 30,
                                  "assets/icons/esewa.png",
                                ),
                                SizedBox(width: 10),
                                Text(
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  "Esewa ",
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPayment = "CashOnDelivery";
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedPayment == "CashOnDelivery"
                            ? const Color.fromARGB(255, 227, 227, 227)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  height: 30,
                                  width: 30,
                                  "assets/icons/cash.png",
                                ),
                                SizedBox(width: 10),
                                Text(
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  "Cash on Delivery ",
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            // height: 100,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 104, 104, 104),
                        ),
                        "Order:",
                      ),
                      Text(
                        style: TextStyle(fontWeight: FontWeight.w600),
                        getTotalAmount().toString(),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 104, 104, 104),
                        ),
                        "Delivery:",
                      ),
                      Text(
                        style: TextStyle(fontWeight: FontWeight.w600),
                        "$deliveryCharge",
                      ),
                    ],
                  ),
                  SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 104, 104, 104),
                        ),
                        "Grand total:",
                      ),
                      Text(
                        style: TextStyle(fontWeight: FontWeight.w600),
                        "${getTotalAmount() - deliveryCharge}",
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                            const Color.fromARGB(255, 255, 0, 8),
                          ),
                        ),
                        onPressed: handelPlaceOrder,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: isSubmitting
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text("Place Order"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
