import 'package:ecommerce/common/model/itemModel.dart';
import 'package:flutter/material.dart';

class Hiveprovider extends ChangeNotifier {
  List<itemsModel> items = [];

  void add(itemsModel newValue) {
    items.add(newValue);
    notifyListeners();
  }

  void remove() {
    items.removeLast();
    notifyListeners();
  }
}
