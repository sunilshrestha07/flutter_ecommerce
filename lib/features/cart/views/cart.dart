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
  bool isSelected = false;
  List<CartItemModel> _allListInHive = [];
  List<CartItemModel> _selectedItem = [];

  // method to clear cart
  void clearCart() async {
    await _cartBox.clear();
    setState(() {
      _allListInHive = [];
    });
  }

  // handel the item count increase
  void increaseItemCount(key) async {
    final existingItem = _cartBox.get(key);
    existingItem!.itemCount = (existingItem.itemCount ?? 1) + 1;
    await existingItem.save();
    setState(() {});
  }

  // handel item selected
  void handelItemSelect(item, value) {
    if (_selectedItem.contains(item)) {
      _selectedItem.remove(item);
    } else {
      _selectedItem.add(item);
    }
    setState(() {});
  }

  // handel the item count increase
  void decreaseItemCount(key) async {
    final existingItem = _cartBox.get(key);
    if (existingItem == null) return;

    final currentCount = existingItem.itemCount ?? 1;

    if (currentCount > 1) {
      existingItem.itemCount = currentCount - 1;
      await existingItem.save();
      setState(() {});
    } else {
      await _cartBox.delete(key);
      setState(() {
        _allListInHive = _cartBox.values.toList();
      });
    }
  }

  // calcualte the total amount for checkout
  double getTotalAmount() {
    return _selectedItem
        .map((item) => (item.itemCount ?? 0) * (item.price ?? 0.0))
        .fold(0.0, (item, element) => item + element);
  }

  //remove specific element from the hive
  void removeSpecificItem(key, item) async {
    await _cartBox.delete(key);
    _selectedItem.remove(item);
    setState(() {
      _allListInHive = _cartBox.values.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _allListInHive = _cartBox.values.toList();
    });
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

      body: _allListInHive.isEmpty
          ? Center(
              child: Text(
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                "No product in the cart !",
              ),
            )
          : Column(
              children: [
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: _allListInHive.length,
                    itemBuilder: (context, index) {
                      final item = _allListInHive[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 227, 227, 227),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _selectedItem.contains(item),
                                    onChanged: (value) {
                                      handelItemSelect(item, value);
                                    },
                                  ),
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
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FractionallySizedBox(
                                          widthFactor: 0.9,
                                          child: Text(
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.clip,
                                            item.name.toString(),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                  255,
                                                  96,
                                                  96,
                                                  96,
                                                ),
                                                fontSize: 13,
                                              ),
                                              "Color : ${item.color}",
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                  255,
                                                  96,
                                                  96,
                                                  96,
                                                ),
                                                fontSize: 13,
                                              ),
                                              "Size : ${item.size}",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                IconButton(
                                                  onPressed: () =>
                                                      decreaseItemCount(item.sId),
                                                  icon: Icon(Icons.remove),
                                                ),
                                                SizedBox(width: 4),
                                                Text(item.itemCount.toString()),
                                                SizedBox(width: 4),
                                                IconButton(
                                                  onPressed: () =>
                                                      increaseItemCount(item.sId),
                                                  icon: Icon(Icons.add),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 50),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    size: 14,
                                                    Icons.currency_rupee_rounded,
                                                  ),
                                                  Text(
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    "${(item.price ?? 0) * (item.itemCount ?? 0)}",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 6,
                              right: 0,
                              child: IconButton(
                                onPressed: () => removeSpecificItem(item.sId, item),
                                icon: Icon(
                                  size: 20,
                                  color: Colors.red,
                                  Icons.delete_outline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 224, 224, 224),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                "Total amount:",
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(size: 20, Icons.currency_rupee),
                                  Text(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                    getTotalAmount().toStringAsFixed(1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {},
                                child: Text("Checkout"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
