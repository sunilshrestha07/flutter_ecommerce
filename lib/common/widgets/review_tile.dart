import 'package:ecommerce/common/model/itemModel.dart';
import 'package:ecommerce/common/model/review_model.dart';
import 'package:ecommerce/common/provider/item_provider.dart';
import 'package:ecommerce/common/widgets/specifici_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReviewTile extends StatelessWidget {
  final reviewmodel items;
  // final itemsModel allItems;
  const ReviewTile({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ItemProvider>(context);
    final itemsModel product = productProvider.allItems.firstWhere(
      (item) => item.sId == items.postId,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: Container(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            product.image.toString(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            // "Wireless airpods",
                            product.name.toString(),
                          ),
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (int index) => Icon(
                                  color: index < (items.rating ?? 0)
                                      ? Colors.amber
                                      : Colors.blueGrey,
                                  size: 20,
                                  // Icons.star,
                                  (index < (items.rating ?? 0)
                                      ? Icons.star
                                      : Icons.star_border_outlined),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromARGB(255, 117, 117, 117),
                                  ),
                                  items.comment.toString(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    color: const Color.fromARGB(255, 117, 117, 117),
                    size: 14,
                    Icons.calendar_today_outlined,
                  ),
                  SizedBox(width: 5),
                  Text(
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 117, 117, 117),
                    ),
                    "Reviewed on",
                  ),
                  SizedBox(width: 5),
                  Text(
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 117, 117, 117),
                    ),
                    DateFormat.yMMMMd().format(
                      DateTime.parse(items.createdAt.toString()),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(5),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        width: 1,
                        color: const Color.fromARGB(255, 156, 156, 156),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecificiItemWidget(item: product),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(style: TextStyle(color: Colors.black), "View Product"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
