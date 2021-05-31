// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  UserData data;
  List<Error> error;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error == null
            ? null
            : List<dynamic>.from(error.map((x) => x.toJson())),
      };
}

class UserData {
  UserData({
    this.id,
    this.name,
    this.phoneNumber,
    this.countryCode,
    this.photo,
    this.active,
    this.type,
    this.commissionStatus,
    this.apiToken,
    this.createdAt,
    this.carType,
    this.cityId,
    this.city,
    this.regionId,
    this.region,
    this.identity,
    this.license,
    this.carForm,
    this.driverPrice,
    this.photos,
    this.details,
    this.longitude,
    this.latitude,
    this.address,
    this.departmentId,
    this.department,
    this.productsNumber,
    this.viewCount,
    this.openTime,
    this.closeTime,
    this.favorite,
    this.available
  });

  int id;
  String name;
  String phoneNumber;
  int countryCode;
    List<Photo> photos;
  int active;
  int type;
  int commissionStatus;
  String apiToken;
  DateTime createdAt;
  int carType;
  int cityId;
  String city;
  int regionId;
  String region;
  String identity;
  String license;
  String carForm;
  dynamic driverPrice;
  String photo;
  String details;
  String longitude;
  String latitude;
  String address;
  int departmentId;
  String department;
  int productsNumber;
  int viewCount;
  String openTime;
  String closeTime;
  int favorite;
  bool available;


  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        photo: json["photo"] == null ? null : json["photo"],
        active: json["active"] == null ? null : json["active"],
        type: json["type"] == null ? null : json["type"],
        commissionStatus: json["commission_status"] == null
            ? null
            : json["commission_status"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        carType: json["car_type"] == null ? null : json["car_type"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        city: json["city"] == null ? null : json["city"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        region: json["region"] == null ? null : json["region"],
        identity: json["identity"] == null ? null : json["identity"],
        license: json["license"] == null ? null : json["license"],
        carForm: json["car_form"] == null ? null : json["car_form"],
        driverPrice: json["driver_price"],
              photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        details: json["details"] == null ? null : json["details"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        address: json["address"] == null ? null : json["address"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        department: json["department"] == null ? null : json["department"],
        productsNumber:
            json["products_number"] == null ? null : json["products_number"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
        openTime: json["open_time"] == null ? null : json["open_time"],
        closeTime: json["close_time"] == null ? null : json["close_time"],
        favorite: json["favorite"] == null ? null : json["favorite"],
        available: json["available"] == null ? false : json["available"],

      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "country_code": countryCode == null ? null : countryCode,
        "photo": photo == null ? null : photo,
        "active": active == null ? null : active,
        "type": type == null ? null : type,
        "commission_status": commissionStatus == null ? null : commissionStatus,
        "api_token": apiToken == null ? null : apiToken,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "car_type": carType == null ? null : carType,
        "city_id": cityId == null ? null : cityId,
        "city": city == null ? null : city,
        "region_id": regionId == null ? null : regionId,
        "region": region == null ? null : region,
        "identity": identity == null ? null : identity,
        "license": license == null ? null : license,
        "car_form": carForm == null ? null : carForm,
        "driver_price": driverPrice,
        "photos": photos == null ? null : photos,
        "details": details == null ? null : details,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "address": address == null ? null : address,
        "department_id": departmentId == null ? null : departmentId,
        "department": department == null ? null : department,
        "products_number": productsNumber == null ? null : productsNumber,
        "view_count": viewCount == null ? null : viewCount,
        "open_time": openTime == null ? null : openTime,
        "close_time": closeTime == null ? null : closeTime,
        "favorite": favorite == null ? null : favorite,
        "available": available == null ? false : available,
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "shop_id": shopId == null ? null : shopId,
        "photo": photo == null ? null : photo,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    };
}
