// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  User? user;
  String? token;
  String? message;
  int? statusCode;

  UserModel({
    this.user,
    this.token,
    this.message,
    this.statusCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    message: json["message"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "message": message,
    "statusCode": statusCode,
  };
}

class User {
  String? id;
  String? name;
  bool? verified;
  String? image;
  String? phone;
  int? wallet;
  bool? available;
  List<dynamic>? viewedReels;
  String? deviceToken;

  User({
    this.id,
    this.name,
    this.verified,
    this.image,
    this.phone,
    this.wallet,
    this.available,
    this.viewedReels,
    this.deviceToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    verified: json["verified"],
    image: json["image"],
    phone: json["phone"],
    wallet: json["wallet"],
    available: json["available"],
    viewedReels: json["viewedReels"] == null ? [] : List<dynamic>.from(json["viewedReels"]!.map((x) => x)),
    deviceToken: json["deviceToken"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "verified": verified,
    "image": image,
    "phone": phone,
    "wallet": wallet,
    "available": available,
    "viewedReels": viewedReels == null ? [] : List<dynamic>.from(viewedReels!.map((x) => x)),
    "deviceToken": deviceToken,
  };
}
