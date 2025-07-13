import 'dart:convert';

import 'package:ecommerce/common/widgets/order_tile.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/myorders/model/orders_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List orderStatus = ["Pending", "Delivered", "Shipped"];
  String selectedStatus = "Pending";
  List<OrdersModel> orderDetails = [];
  bool isFetching = false;
  final _userDeatilsBox = Hive.box<UserModel>("userDetailsHiveBox");
  List<UserModel> loggedInUser = [];

  // method to fetch the orders lists
  Future<void> fetchOrdersDetails() async {
    try {
      setState(() {
        isFetching = true;
      });
      final url = "https://fashion-fusion-suneel.vercel.app/api/order";
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        // final List orderData = da
        final List orderdata = data["orders"];
        setState(() {
          orderDetails = orderdata.map((json) => OrdersModel.fromJson(json)).toList();
        });
        setState(() {
          isFetching = false;
        });
      } else {
        setState(() {
          isFetching = false;
        });
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(
          SnackBar(
            duration: Durations.long2,
            content: Text("Error fetching the orders "),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error fetching the orders $e");
      setState(() {
        isFetching = false;
      });
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(
        SnackBar(
          duration: Durations.long2,
          content: Text("Error fetching the orders $e"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loggedInUser = _userDeatilsBox.values.toList();
    });
    // print(loggedInUser);
    fetchOrdersDetails();
  }

  @override
  Widget build(BuildContext context) {
    final List<OrdersModel> filteredOrders = orderDetails
        .where(
          (item) => item.status == selectedStatus && item.userId == loggedInUser[0].sId,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              "My Orders",
            ),

            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => setState(() {
                      selectedStatus = orderStatus[0];
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedStatus == orderStatus[0]
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedStatus == orderStatus[0]
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          orderStatus[0],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => setState(() {
                      selectedStatus = orderStatus[1];
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedStatus == orderStatus[1]
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedStatus == orderStatus[1]
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          orderStatus[1],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => setState(() {
                      selectedStatus = orderStatus[2];
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedStatus == orderStatus[2]
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: selectedStatus == orderStatus[2]
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          orderStatus[2],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: isFetching
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: fetchOrdersDetails,
                      child: ListView.builder(
                        dragStartBehavior: DragStartBehavior.start,
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          return OrderTile(items: filteredOrders[index]);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
