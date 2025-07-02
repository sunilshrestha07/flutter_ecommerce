import 'package:ecommerce/common/widgets/men_category.dart';
import 'package:ecommerce/common/widgets/women_category.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  String _selectedCategory = 'Men';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: true,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 10), child: Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = "Women";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 5,
                            color: _selectedCategory == "Women"
                                ? const Color.fromARGB(255, 226, 81, 70)
                                : Colors.white,
                          ),
                        ),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: _selectedCategory == "Women"
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        "Women",
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = "Men";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 5,
                            color: _selectedCategory == "Men"
                                ? const Color.fromARGB(255, 226, 81, 70)
                                : Colors.white,
                          ),
                        ),
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: _selectedCategory == "Men"
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        "Men",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _selectedCategory == "Women" ? WomenCategory() : MenCategory(),
          ],
        ),
      ),
    );
  }
}
