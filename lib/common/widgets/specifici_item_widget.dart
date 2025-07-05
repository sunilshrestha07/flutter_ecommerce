import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:ecommerce/common/hiveobject/cart_item_model.dart';
import 'package:ecommerce/common/model/itemModel.dart';
import 'package:ecommerce/common/widgets/specific_item_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  // create the box for the items to read and store
  final _cartBox = Hive.box<CartItemModel>("cartItemBox");

  //handel add to cart
  void addToCart(itemsModel item) async {
    final newItem = CartItemModel(
      sId: item.sId,
      name: item.name,
      image: item.image,
      description: item.description,
      price: item.price,
      discount: item.discount,
      category: item.category,
      sale: item.sale,
      rating: item.rating,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
      itemCount: 1,
    );

    final key = item.sId;

    // if same item exist increase the item count else add to the box
    if (_cartBox.containsKey(key)) {
      final existingItem = _cartBox.get(key);
      existingItem!.itemCount = (existingItem.itemCount ?? 1) + 1;
      await existingItem.save();
    } else {
      _cartBox.put(key, newItem);
    }
  }

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
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(
                          widget.item.image.toString(),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),

                      Positioned(
                        top: 50,
                        left: 20,

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                    ],
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
                          onPressed: () => addToCart(widget.item),
                          child: Text(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            "Add To Cart",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // review and ratings
            SpecificItemComments(sId: widget.item.sId, rating: widget.item.rating),
          ],
        ),
      ),
    );
  }
}
