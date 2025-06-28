import 'package:ecommerce/common/model/itemModel.dart';
import 'package:flutter/material.dart';

class Hiveprovider extends ChangeNotifier {
  List<itemsModel> saleItems = [];
  List<itemsModel> newItems = [];

  void addNewItems(itemsModel newValue) {
    newItems.add(newValue);
    notifyListeners();
  }

  void addSaleItem(itemsModel newValue) {
    saleItems.add(newValue);
    notifyListeners();
  }
}
