// To parse this JSON data, do
//
//     final adsModel = adsModelFromJson(jsonString);

import 'dart:convert';

import 'package:khatwa_client/Core/api/constant_api.dart';

AdsModel adsModelFromJson(String str) => AdsModel.fromJson(json.decode(str));

String adsModelToJson(AdsModel data) => json.encode(data.toJson());

class AdsModel {
  List<Ad>? ads;
  int? statusCode;

  AdsModel({
    this.ads,
    this.statusCode,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
    ads: json["ads"] == null ? [] : List<Ad>.from(json["ads"]!.map((x) => Ad.fromJson(x))),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "ads": ads == null ? [] : List<dynamic>.from(ads!.map((x) => x.toJson())),
    "statusCode": statusCode,
  };
}

class Ad {
  String? id;
  String? image;
  int? v;

  Ad({
    this.id,
    this.image,
    this.v,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json["_id"],
    image: Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}images/${json["image"]}',).toString(),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "__v": v,
  };
}
