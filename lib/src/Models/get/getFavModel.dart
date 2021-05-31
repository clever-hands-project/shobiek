// To parse this JSON data, do
//
//     final getmyFavModel = getmyFavModelFromJson(jsonString);

import 'dart:convert';

GetmyFavModel getmyFavModelFromJson(String str) =>
    GetmyFavModel.fromJson(json.decode(str));

String getmyFavModelToJson(GetmyFavModel data) => json.encode(data.toJson());

class GetmyFavModel {
  GetmyFavModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Fav> data;
  List<Error> error;

  factory GetmyFavModel.fromJson(Map<String, dynamic> json) => GetmyFavModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Fav>.from(json["data"].map((x) => Fav.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Fav {
  Fav({
    this.id,
    this.name,
    this.phoneNumber,
    this.countryCode,
    this.photo,
    this.photos,
    this.active,
    this.type,
    this.details,
    this.longitude,
    this.latitude,
    this.address,
    this.cityId,
    this.city,
    this.regionId,
    this.region,
    this.departmentId,
    this.department,
    this.productsNumber,
    this.viewCount,
    this.commissionStatus,
    this.openTime,
    this.closeTime,
    this.favorite,
    this.apiToken,
    this.createdAt,
  });

  int id;
  String name;
  String phoneNumber;
  int countryCode;
  dynamic photo;
  dynamic photos;
  int active;
  int type;
  String details;
  String longitude;
  String latitude;
  String address;
  int cityId;
  dynamic city;
  int regionId;
  String region;
  int departmentId;
  String department;
  int productsNumber;
  int viewCount;
  int commissionStatus;
  dynamic openTime;
  dynamic closeTime;
  int favorite;
  String apiToken;
  DateTime createdAt;

  factory Fav.fromJson(Map<String, dynamic> json) => Fav(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        photo: json["photo"],
        photos: json["photos"],
        active: json["active"] == null ? null : json["active"],
        type: json["type"] == null ? null : json["type"],
        details: json["details"] == null ? null : json["details"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        address: json["address"] == null ? null : json["address"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        city: json["city"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        region: json["region"] == null ? null : json["region"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        department: json["department"] == null ? null : json["department"],
        productsNumber:
            json["products_number"] == null ? null : json["products_number"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
        commissionStatus: json["commission_status"] == null
            ? null
            : json["commission_status"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
        favorite: json["favorite"] == null ? null : json["favorite"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "country_code": countryCode == null ? null : countryCode,
        "photo": photo,
        "photos": photos,
        "active": active == null ? null : active,
        "type": type == null ? null : type,
        "details": details == null ? null : details,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "address": address == null ? null : address,
        "city_id": cityId == null ? null : cityId,
        "city": city,
        "region_id": regionId == null ? null : regionId,
        "region": region == null ? null : region,
        "department_id": departmentId == null ? null : departmentId,
        "department": department == null ? null : department,
        "products_number": productsNumber == null ? null : productsNumber,
        "view_count": viewCount == null ? null : viewCount,
        "commission_status": commissionStatus == null ? null : commissionStatus,
        "open_time": openTime,
        "close_time": closeTime,
        "favorite": favorite == null ? null : favorite,
        "api_token": apiToken == null ? null : apiToken,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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
