class itemsModel {
  String? sId;
  String? name;
  String? image;
  String? description;
  int? price;
  int? discount;
  String? category;
  bool? sale;
  int? rating;
  String? createdAt;
  String? updatedAt;

  itemsModel({
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
  });

  itemsModel.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['category'] = this.category;
    data['sale'] = this.sale;
    data['rating'] = this.rating;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
