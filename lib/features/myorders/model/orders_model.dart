class OrdersModel {
  String? sId;
  String? userId;
  String? userName;
  String? userEmail;
  String? dressName;
  int? quantity;
  int? totalPrice;
  String? status;
  String? createdAt;
  String? updatedAt;

  OrdersModel({
    this.sId,
    this.userId,
    this.userName,
    this.userEmail,
    this.dressName,
    this.quantity,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    dressName = json['dressName'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['dressName'] = this.dressName;
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
