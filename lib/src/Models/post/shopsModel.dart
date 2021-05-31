// To parse this JSON data, do
//
//     final shopsModel = shopsModelFromJson(jsonString);

import 'dart:convert';

import 'package:shobek/src/Models/get/photoModle.dart';

ShopsModel shopsModelFromJson(String str) =>
    ShopsModel.fromJson(json.decode(str));

String shopsModelToJson(ShopsModel data) => json.encode(data.toJson());

class ShopsModel {
  ShopsModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Shops> data;
  List<Error> error;

  factory ShopsModel.fromJson(Map<String, dynamic> json) => ShopsModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<Shops>.from(json["data"].map((x) => Shops.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Shops {
  Shops({
    this.id,
    this.name,
    this.phoneNumber,
    this.countryCode,
    this.photo,
    this.photos,
    this.active,
    this.type,
    this.longitude,
    this.latitude,
    this.address,
    this.details,
    this.cityId,
    this.city,
    this.regionId,
    this.region,
    this.departmentId,
    this.department,
    this.productsNumber,
    this.viewCount,
    this.commissionStatus,
    this.favorite,
    this.open,
    this.distance,
    this.apiToken,
    this.createdAt,
  });

  int id;
  String name;
  String phoneNumber;
  int countryCode;
  String photo;
  List<Photo> photos;
  int active;
  int type;
  String longitude;
  String latitude;
  String address;
  String details;
  int distance;
  int cityId;
  String city;
  int regionId;
  String region;
  int departmentId;
  String department;
  int productsNumber;
  int viewCount;
  int commissionStatus;
  int favorite;
  int open;
  String apiToken;
  DateTime createdAt;

  factory Shops.fromJson(Map<String, dynamic> json) => Shops(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
        photo: json["photo"] == null ? null : json["photo"],
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        active: json["active"],
        type: json["type"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        address: json["address"] == null ? null : json["address"],
        details: json["details"] == null ? null : json["details"],
        cityId: json["city_id"],
        city: json["city"],
        regionId: json["region_id"],
        region: json["region"],
        departmentId: json["department_id"],
        department: json["department"],
        productsNumber: json["products_number"],
        viewCount: json["view_count"],
        commissionStatus: json["commission_status"],
        favorite: json["favorite"],
        open: json["open"],
        apiToken: json["api_token"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "photo": photo == null ? null : photo,
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos.map((x) => x.toJson())),
        "active": active,
        "type": type,
        "longitude": longitude,
        "latitude": latitude,
        "address": address == null ? null : address,
        "details": details == null ? null : details,
        "city_id": cityId,
        "city": city,
        "region_id": regionId,
        "region": region,
        "department_id": departmentId,
        "department": department,
        "products_number": productsNumber,
        "view_count": viewCount,
        "commission_status": commissionStatus,
        "favorite": favorite,
        "open": open,
        "api_token": apiToken,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}



class Error {
  Error({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}
