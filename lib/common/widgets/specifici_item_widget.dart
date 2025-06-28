import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
  String selectedColor = "Black";
  List<String> itemSizesOptions = ["XXL", "XL", "L", "M"];
  List<String> itemColorOptions = ["Black", "White", "Blue"];
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.3;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image of the product
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 5.4,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      widget.item.image.toString(),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // size and the color of the product
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomDropdown<String>(
                      hintText: 'Select job role',
                      items: itemSizesOptions,
                      initialItem: itemSizesOptions[0],
                      onChanged: (value) {
                        setState(() {
                          selectedSize = value!;
                        });
                      },
                      decoration: CustomDropdownDecoration(
                        closedFillColor: const Color.fromARGB(0, 156, 156, 156),
                        // expandedFillColor:
                      ),
                    ),
                  ),

                  SizedBox(width: 8),
                  // drop down for the color
                  Expanded(
                    child: CustomDropdown<String>(
                      hintText: 'Select color',
                      items: itemColorOptions,
                      initialItem: itemColorOptions[0],
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      },
                      decoration: CustomDropdownDecoration(
                        closedFillColor: const Color.fromARGB(0, 156, 156, 156),
                        // expandedFillColor:
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
                        Row(
                          children: [
                            Icon(Icons.currency_rupee_sharp),

                            Text(
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              widget.item.price.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // discrtition
                    Text(
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 84, 84, 84),
                      ),
                      widget.item.description.toString(),
                    ),

                    // buy and add to cart buttons
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(
                                Size(double.infinity, 50),
                              ),
                              backgroundColor: WidgetStateProperty.all(Colors.red),
                            ),
                            onPressed: () {},
                            child: Text(
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              "Buy Now",
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(Size(130, 50)),
                            backgroundColor: WidgetStateProperty.all(Colors.black),
                          ),
                          onPressed: () {},
                          child: Text(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            "Buy Now",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // discription and add to cart and buy options
          ],
        ),
      ),
    );
  }
}
