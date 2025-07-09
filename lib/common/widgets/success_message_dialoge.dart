import 'package:flutter/material.dart';

class SuccessMessageDialoge extends StatelessWidget {
  final String price;
  final String method;
  const SuccessMessageDialoge({super.key, required this.price, required this.method});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 260,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            children: [
              Icon(size: 40, color: Colors.green, Icons.check_circle_outlined),
              Text(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                "Order Placed Successful",
              ),
              Text(
                textAlign: TextAlign.center,
                "Thank you for your order. Your order will be processd shortly",
              ),

              Divider(height: 20),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 113, 113, 113),
                      ),
                      "Amount Paid",
                    ),
                    Text(style: TextStyle(fontWeight: FontWeight.w600), price),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 113, 113, 113),
                      ),
                      "Payment Method",
                    ),
                    Text(style: TextStyle(fontWeight: FontWeight.w600), method),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 113, 113, 113),
                      ),
                      "Date & Time",
                    ),
                    Text(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      DateTime.now().toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
