import 'dart:convert';

import 'package:ecommerce/common/hiveProvider/hiveprovider.dart';
import 'package:ecommerce/common/model/itemModel.dart';
import 'package:ecommerce/common/widgets/itemsscrollsmall/item_scroll_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<itemsModel> _allItems = [];
  bool isFetching = false;

  // fetch data
  Future<void> fetchData() async {
    try {
      setState(() {
        isFetching = true;
      });
      final response = await http.get(
        Uri.parse("https://fashion-fusion-suneel.vercel.app/api/dress"),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List itemList = data['dress'];
        setState(() {
          _allItems = itemList.map((json) => itemsModel.fromJson(json)).toList();
          isFetching = false;

          //adding for statemanagment
          final itemProvider = Provider.of<Hiveprovider>(context, listen: false);
          for (var item in _allItems) {
            itemProvider.add(item);
          }
        });
      } else {
        debugPrint("Error fetching data");
        setState(() {
          isFetching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[200],
            content: Center(
              child: Text(
                style: TextStyle(color: Colors.black, fontSize: 16),
                "Error fetching data Internal server error!",
              ),
            ),
          ),
        );
      }
    } catch (e) {
      SnackBarAction(label: "Error fetching the items", onPressed: () {});
      setState(() {
        isFetching = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Hiveprovider>(
      builder: (context, itemProvider, child) => Scaffold(
        body: isFetching
            ? Center(child: CircularProgressIndicator(color: Colors.red))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // hero section like image and the title section
                    Stack(
                      children: [
                        Image.asset("assets/images/homeImage.jpeg"),
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 1,
                                    ),
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

                    // dynamic content for the product with scroll
                    SizedBox(height: 20),
                    // new arrivale title
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
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                ),
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
                    // scroll using the listview for the new produts
                    SizedBox(height: 30),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        cacheExtent: 5000,
                        scrollDirection: Axis.horizontal,
                        itemCount: _allItems.length,
                        itemBuilder: (context, index) =>
                            ItemScrollTile(allItems: _allItems[index]),
                      ),
                    ),

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
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                ),
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
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        cacheExtent: 5000,
                        scrollDirection: Axis.horizontal,
                        itemCount: _allItems.length,
                        itemBuilder: (context, index) =>
                            ItemScrollTile(allItems: _allItems[index]),
                      ),
                    ),
                    Text(itemProvider.items.map((e) => e.name).join(' ')),
                    // scroll using the listview for the new produts
                  ],
                ),
              ),
      ),
    );
  }
}
