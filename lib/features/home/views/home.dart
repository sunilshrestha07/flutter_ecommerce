import 'package:ecommerce/common/provider/item_provider.dart';
import 'package:ecommerce/common/widgets/itemsscrollsmall/item_scroll_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, itemProvider, _) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // hero section like image and the title section
              Stack(
                children: [
                  Image.asset(
                    height: 500,
                    // cacheHeight: 500,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    "assets/images/homeImage.jpeg",
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              height: 0.9,
                            ),
                            "Fashion",
                          ),
                          Text(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              height: 1,
                            ),
                            "Sale ",
                          ),
                          SizedBox(height: 5),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.red),
                            ),
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                              child: Text(
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                "Check",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // sale category part
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                          "Sale",
                        ),
                        InkWell(
                          child: Text(
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey[500],
                            ),
                            "View all",
                          ),
                        ),
                      ],
                    ),
                    Text("Super summer sale"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  cacheExtent: 5000,
                  scrollDirection: Axis.horizontal,
                  itemCount: itemProvider.saleItems.length,
                  itemBuilder: (context, index) =>
                      ItemScrollTile(allItems: itemProvider.saleItems[index]),
                ),
              ),

              //new arrival herosecion
              SizedBox(height: 20),
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 11,

                    child: Image.asset(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      "assets/images/new.jpeg",
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.black),
                            ),
                            onPressed: () {
                              itemProvider.saleItems.length;
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                              child: Text(
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                "Check",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //new cartegory section
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                          "New",
                        ),
                        InkWell(
                          child: Text(
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey[500],
                            ),
                            "View all",
                          ),
                        ),
                      ],
                    ),
                    Text("You've never seen it before!"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  cacheExtent: 5000,
                  scrollDirection: Axis.horizontal,
                  itemCount: itemProvider.newItems.length,
                  itemBuilder: (context, index) =>
                      ItemScrollTile(allItems: itemProvider.newItems[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
