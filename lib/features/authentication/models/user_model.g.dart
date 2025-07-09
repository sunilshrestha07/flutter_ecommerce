// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      sId: fields[1] as String?,
      userName: fields[2] as String?,
      email: fields[3] as String?,
      isVerified: fields[4] as bool?,
      isAdmin: fields[5] as bool?,
      verificationCode: fields[6] as String?,
      verificationExpires: fields[7] as DateTime?,
      createdAt: fields[8] as String?,
      updatedAt: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.sId)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.isVerified)
      ..writeByte(5)
      ..write(obj.isAdmin)
      ..writeByte(6)
      ..write(obj.verificationCode)
      ..writeByte(7)
      ..write(obj.verificationExpires)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
