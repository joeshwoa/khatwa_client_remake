import 'package:khatwa_client/Core/api/constant_api.dart';

class ClientProfileModel {
  String? sId;
  String? name;
  String? email;
  String? gander;
  int? age;
  String? phone;
  bool? verified;
  String? password;
  String? image;
  String? role;
  String? googleId;
  bool? available;
  int? iV;
  var wallet;

  ClientProfileModel(
      {this.sId,
        this.name,
        this.email,
        this.verified,
        this.password,
        this.image,
        this.role,
        this.available,
        this.phone,
        this.gander,
        this.age,
        this.iV,
        this.wallet,
      });

  ClientProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
    password = json['password'];
    image = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}images/${json["image"]}',).toString();
    role = json['role'];
    phone = json['phone'];
    gander = json['gender'];
    googleId = json['googleId'];
    age = json['age']??0;
    available = json['available'];
    iV = json['__v'];
    wallet=json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['verified'] = verified;
    data['phone'] = phone;
    data['age'] = age;
    data['gender'] = gander;
    data['password'] = password;
    data['image'] = image;
    data['role'] = role;
    data['googleId'] = googleId;
    data['available'] = available;
    data['__v'] = iV;
    data['wallet']=wallet;
    return data;
  }
}
