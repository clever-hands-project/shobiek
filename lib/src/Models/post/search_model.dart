// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Search> data;
  List<Error> error;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Search>.from(json["data"].map((x) => Search.fromJson(x))),
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

class Search {
  Search({
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
    this.distance,
    this.commissionStatus,
    this.favorite,
    this.open,
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
  dynamic details;
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
  int distance;
  int open;
  String apiToken;
  DateTime createdAt;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        photo: json["photo"] == null ? null : json["photo"],
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        active: json["active"] == null ? null : json["active"],
        type: json["type"] == null ? null : json["type"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        address: json["address"] == null ? null : json["address"],
        details: json["details"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        city: json["city"] == null ? null : json["city"],
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
        favorite: json["favorite"] == null ? null : json["favorite"],
        open: json["open"] == null ? null : json["open"],
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
        "photo": photo == null ? null : photo,
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos.map((x) => x.toJson())),
        "active": active == null ? null : active,
        "type": type == null ? null : type,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "address": address == null ? null : address,
        "details": details,
        "city_id": cityId == null ? null : cityId,
        "city": city == null ? null : city,
        "region_id": regionId == null ? null : regionId,
        "region": region == null ? null : region,
        "department_id": departmentId == null ? null : departmentId,
        "department": department == null ? null : department,
        "products_number": productsNumber == null ? null : productsNumber,
        "view_count": viewCount == null ? null : viewCount,
        "commission_status": commissionStatus == null ? null : commissionStatus,
        "favorite": favorite == null ? null : favorite,
        "open": open == null ? null : open,
        "api_token": apiToken == null ? null : apiToken,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}

class Photo {
  Photo({
    this.id,
    this.shopId,
    this.photo,
    this.createdAt,
  });

  int id;
  int shopId;
  String photo;
  DateTime createdAt;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"] == null ? null : json["id"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        photo: json["photo"] == null ? null : json["photo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "shop_id": shopId == null ? null : shopId,
        "photo": photo == null ? null : photo,
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
