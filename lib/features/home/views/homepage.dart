import 'dart:convert';
import 'package:ecommerce/common/model/itemModel.dart';
import 'package:ecommerce/common/provider/item_provider.dart';
import 'package:ecommerce/features/cart/views/cart.dart';
import 'package:ecommerce/features/home/views/home.dart';
import 'package:ecommerce/features/profile/views/profile.dart';
import 'package:ecommerce/features/store/views/store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int cuttentPageIndex = 0;
  List<Widget> pages = [Home(), Store(), Cart(), Profile()];
  List<itemsModel> _allItems = [];
  bool isFetching = false;

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
          final itemProvider = Provider.of<ItemProvider>(context, listen: false);
          for (var item in _allItems) {
            if (item.sale == false) {
              itemProvider.addNewItems(item); // Add only this item
            } else {
              itemProvider.addSaleItem(item); // Add only this item
            }
          }
          isFetching = false;

          // adding for statemanagment
        });
      } else {
        debugPrint("Error fetching data");
        setState(() {
          isFetching = false;
        });
        // ignore: use_build_context_synchronously
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
  void dispose() {
    super.dispose();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isFetching
          ? Center(child: CircularProgressIndicator())
          : Center(child: pages[cuttentPageIndex]),

      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: BottomNavigationBar(
            onTap: (int newIndex) {
              setState(() {
                cuttentPageIndex = newIndex;
              });
            },
            currentIndex: cuttentPageIndex,
            unselectedIconTheme: IconThemeData(color: Colors.black),
            showUnselectedLabels: true,
            elevation: 5,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: const Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: const Icon(Icons.store), label: "Store"),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_bag_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
