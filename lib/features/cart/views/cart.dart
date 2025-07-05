import 'package:ecommerce/common/hiveobject/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _cartBox = Hive.box<CartItemModel>("cartItemBox");
  List<CartItemModel> _allListInHive = [];

  // method to clear cart
  void clearCart() async {
    await _cartBox.clear();
    setState(() {
      _allListInHive = [];
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _allListInHive = _cartBox.values.toList();
    });
    print(_allListInHive.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(style: TextStyle(fontWeight: FontWeight.w500), "My Cart"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: clearCart,
              icon: Icon(size: 25, Icons.delete_outlined),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: _allListInHive.length,
              itemBuilder: (context, index) {
                final item = _allListInHive[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Checkbox(value: true, onChanged: (e) {}),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                            item.image.toString(),
                          ),
                        ),
                        SizedBox(width: 5),
                        Column(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                              item.name.toString(),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 96, 96, 96),
                                    fontSize: 13,
                                  ),
                                  "Color : Black",
                                ),
                                SizedBox(width: 15),
                                Text(
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 96, 96, 96),
                                    fontSize: 13,
                                  ),
                                  "Size : L",
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.remove),
                                    ),
                                    SizedBox(width: 4),
                                    Text(item.itemCount.toString()),
                                    SizedBox(width: 4),
                                    IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                                  ],
                                ),
                                SizedBox(width: 50),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(size: 14, Icons.currency_rupee_rounded),
                                    Text(
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                      item.price.toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(flex: 1, child: Container(color: Colors.green)),
        ],
      ),
    );
  }
}
