import 'package:ecommerce/common/model/itemModel.dart';
import 'package:ecommerce/common/provider/item_provider.dart';
import 'package:ecommerce/common/widgets/specifici_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemScrollTile extends StatelessWidget {
  final itemsModel allItems;
  const ItemScrollTile({super.key, required this.allItems});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, itemProvider, child) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 241, 241, 241),
          ),
          width: 260,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpecificiItemWidget(item: allItems),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 290,
                        width: 240,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            allItems.image.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 7,
                        left: 7,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: allItems.sale! ? Colors.red : Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: allItems.sale!
                              ? Text(
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  " -${allItems.discount} %",
                                )
                              : Text(
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  "  New ",
                                ),
                        ),
                      ),
                    ],
                  ),
                  // about the item info card
                  SizedBox(height: 5),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // rating show
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Text(
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            allItems.rating.toString(),
                          ),
                        ],
                      ),

                      Text(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        allItems.name.toString(),
                      ),

                      Row(
                        children: [
                          Text(
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red[700],
                              fontWeight: FontWeight.w600,
                            ),
                            allItems.price.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
