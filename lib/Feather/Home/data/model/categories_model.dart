import 'dart:convert';

import 'package:khatwa_client/Core/api/constant_api.dart';

class CategoriesModel {
  List<Category>? categories;

  CategoriesModel({
    this.categories,
  });

  factory CategoriesModel.fromRawJson(String str) => CategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  String? id;
  String? name;
  String? image;
  int? commission;
  bool? delivery;
  bool? riding;
  int? v;

  Category({
    this.id,
    this.name,
    this.image,
    this.commission,
    this.delivery,
    this.riding,
    this.v,
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    image: Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}images/${json["image"]}',).toString(),
    commission: json["commission"],
    delivery: json["delivery"],
    riding: json["riding"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "commission": commission,
    "delivery": delivery,
    "riding": riding,
    "__v": v,
  };
}
