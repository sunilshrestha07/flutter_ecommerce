import 'package:ecommerce/common/model/itemModel.dart';
import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  List<itemsModel> saleItems = [];
  List<itemsModel> newItems = [];
  List<itemsModel> allItems = [];

  void addAllItems(itemsModel newValue) {
    allItems.add(newValue);
    notifyListeners();
  }

  void addNewItems(itemsModel newValue) {
    newItems.add(newValue);
    notifyListeners();
  }

  void addSaleItem(itemsModel newValue) {
    saleItems.add(newValue);
    notifyListeners();
  }
}
