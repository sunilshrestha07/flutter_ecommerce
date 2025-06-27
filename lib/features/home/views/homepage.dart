import 'package:ecommerce/features/cart/views/cart.dart';
import 'package:ecommerce/features/home/views/home.dart';
import 'package:ecommerce/features/profile/views/profile.dart';
import 'package:ecommerce/features/store/views/store.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int cuttentPageIndex = 0;
  List<Widget> pages = [Home(), Store(), Cart(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pages[cuttentPageIndex]),

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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
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
