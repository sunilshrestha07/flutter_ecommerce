import 'package:ecommerce/common/model/itemModel.dart';
import 'package:ecommerce/common/widgets/specifici_item_widget.dart';
import 'package:flutter/material.dart';

class CategoryBasedItemtile extends StatelessWidget {
  final itemsModel allItems;
  const CategoryBasedItemtile({super.key, required this.allItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 2,
            color: const Color.fromARGB(255, 170, 170, 170),
          ),
          BoxShadow(
            offset: Offset(-1, -1),
            blurRadius: 4,
            color: const Color.fromARGB(255, 170, 170, 170),
          ),
        ],
      ),
      // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.all(5),
      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpecificiItemWidget(item: allItems)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  height: 200,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(allItems.image.toString(), fit: BoxFit.cover),
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
                        (index) =>
                            const Icon(Icons.star, color: Colors.amberAccent, size: 20),
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      allItems.rating.toString(),
                    ),
                  ],
                ),

                Text(
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  allItems.name.toString(),
                ),

                Row(
                  children: [
                    Text(
                      style: TextStyle(
                        fontSize: 15,
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
    );
  }
}
