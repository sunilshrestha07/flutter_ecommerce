import 'package:ecommerce/common/model/itemModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SpecificiItemWidget extends StatefulWidget {
  final itemsModel item;
  const SpecificiItemWidget({super.key, required this.item});

  @override
  State<SpecificiItemWidget> createState() => _SpecificiItemWidgetState();
}

class _SpecificiItemWidgetState extends State<SpecificiItemWidget> {
  String selectedSize = "Size";
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.3;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image of the product
            AspectRatio(
              aspectRatio: 4 / 6,
              child: Image.network(
                widget.item.image.toString(),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),

            // size and the color of the product

            //name and discription of the product
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          widget.item.name.toString(),
                        ),
                        Text(
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          widget.item.price.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
