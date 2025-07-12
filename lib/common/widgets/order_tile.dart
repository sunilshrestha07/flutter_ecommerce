import 'package:ecommerce/features/myorders/model/orders_model.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final OrdersModel items;
  const OrderTile({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 40,
        // width: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 199, 199, 199),
              // offset: Offset(5, 5),
              blurRadius: 10,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    style: TextStyle(fontWeight: FontWeight.bold),

                    "Order Id: ${items.sId}",
                  ),
                  Text(
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 139, 139, 139),
                    ),
                    // "${items.createdAt}",
                    "07-15-2025",
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 117, 117, 117),
                            ),
                            "Quantity :",
                          ),
                          SizedBox(width: 10),
                          Text(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            items.quantity.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3),

                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 117, 117, 117),
                            ),
                            "Total Amount:",
                          ),
                          SizedBox(width: 10),
                          Text(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            "Rs: ${items.totalPrice}",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      side: WidgetStatePropertyAll(BorderSide(color: Colors.black)),
                    ),
                    onPressed: () {},
                    child: Text(style: TextStyle(color: Colors.black), "Review"),
                  ),
                  Text(style: TextStyle(fontWeight: FontWeight.w500), "${items.status}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
