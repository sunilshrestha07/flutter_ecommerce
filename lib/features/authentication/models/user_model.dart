import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3, adapterName: "UserModelAdapter")
class UserModel extends HiveObject {
  @HiveField(1)
  String? sId;
  @HiveField(2)
  String? userName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  bool? isVerified;
  @HiveField(5)
  bool? isAdmin;
  @HiveField(6)
  String? verificationCode;
  @HiveField(7)
  DateTime? verificationExpires;
  @HiveField(8)
  String? createdAt;
  @HiveField(9)
  String? updatedAt;

  UserModel({
    this.sId,
    this.userName,
    this.email,
    this.isVerified,
    this.isAdmin,
    this.verificationCode,
    this.verificationExpires,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    isVerified = json['isVerified'];
    isAdmin = json['isAdmin'];
    verificationCode = json['verificationCode'];
    verificationExpires = json['verificationExpires'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
