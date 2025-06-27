import 'package:ecommerce/common/hiveProvider/hiveprovider.dart';
import 'package:ecommerce/common/model/itemModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemScrollTile extends StatelessWidget {
  final itemsModel allItems;
  const ItemScrollTile({super.key, required this.allItems});

  @override
  Widget build(BuildContext context) {
    return Consumer<Hiveprovider>(
      builder: (context, itemProvider, child) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            // itemProvider.items.map((e) => {print(e.name)});
            debugPrint("object");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                height: 300,
                width: 240,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(allItems.image.toString(), fit: BoxFit.cover),
                  // child: Image.assets("assets/images/homepage.jpg", fit: BoxFit.cover),
                ),
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
                          (index) =>
                              const Icon(Icons.star, color: Colors.amberAccent, size: 25),
                        ),
                      ),
                      Text(allItems.rating.toString()),
                    ],
                  ),

                  Text(
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    allItems.name.toString(),
                  ),

                  Row(
                    children: [
                      Text(
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 118, 124, 127),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                        ),
                        allItems.price.toString(),
                      ),
                      SizedBox(width: 20),
                      Text(
                        textAlign: TextAlign.end,
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
    );
  }
}
