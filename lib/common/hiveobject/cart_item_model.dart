import 'package:hive_flutter/hive_flutter.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1, adapterName: "CartItemAdapter")
class CartItemModel extends HiveObject {
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;
  @HiveField(3)
  String? description;
  @HiveField(4)
  int? price;
  @HiveField(5)
  int? discount;
  @HiveField(6)
  String? category;
  @HiveField(7)
  bool? sale;
  @HiveField(8)
  int? rating;
  @HiveField(9)
  String? createdAt;
  @HiveField(10)
  String? updatedAt;
  @HiveField(11)
  int? itemCount;

  CartItemModel({
    this.sId,
    this.name,
    this.image,
    this.description,
    this.price,
    this.discount,
    this.category,
    this.sale,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.itemCount,
  });

  CartItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    discount = json['discount'];
    category = json['category'];
    sale = json['sale'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    itemCount = json['itemCount'];
  }
}
