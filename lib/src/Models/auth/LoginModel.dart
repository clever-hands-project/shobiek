// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": data.toJson(),
        "error": error,
      };
}

class Data {
  Data(
      {this.id,
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
      this.cityId,
      this.city,
      this.regionId,
      this.region,
      this.departmentId,
      this.department,
      this.productsNumber,
      this.viewCount,
      this.commissionStatus,
      this.apiToken,
      this.createdAt,
      this.carForm,
      this.driverPrice,
      this.identity,
      this.license,
      this.closeTime,
      this.details,
      this.favorite,
      this.carType,
      this.openTime});

  int id;
  String name;
  String phoneNumber;
  int countryCode;
  String photo;
  dynamic photos;
  int active;
  int type;
  String longitude;
  String latitude;
  String address;
  int cityId;
  String city;
  int regionId;
  String region;
  int departmentId;
  String department;
  int productsNumber;
  int viewCount;
  int commissionStatus;
  String apiToken;
  DateTime createdAt;
  String identity;
  String license;
  String carForm;
  String driverPrice;
  dynamic details;
   String openTime;
    String closeTime;
  int favorite;

    int carType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"],
        photo: json["photo"],
        details: json["details"],
        photos: json["photos"],
        active: json["active"],
        type: json["type"],
        longitude: json["longitude"],
               carType: json["car_type"] == null ? null : json["car_type"],
        latitude: json["latitude"],
        favorite: json["favorite"] == null ? null : json["favorite"],
        address: json["address"],
        cityId: json["city_id"],
         openTime: json["open_time"] == null ? null : json["open_time"],
        closeTime: json["close_time"] == null ? null : json["close_time"],
        city: json["city"],
        regionId: json["region_id"],
        
        region: json["region"],
        departmentId: json["department_id"],
        driverPrice: json["driver_price"] == null ? null : json["driver_price"],
        department: json["department"],
        productsNumber: json["products_number"],
        viewCount: json["view_count"],
        commissionStatus: json["commission_status"],
        identity: json["identity"] == null ? null : json["identity"],
        license: json["license"] == null ? null : json["license"],
        carForm: json["car_form"] == null ? null : json["car_form"],
        apiToken: json["api_token"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "photo": photo,
        "photos": photos,
        "active": active,
        "type": type,
        "longitude": longitude,
        "latitude": latitude,
        "address": address,
        "city_id": cityId,
        "city": city,
        "region_id": regionId,
        "region": region,
        "department_id": departmentId,
        "department": department,
        "products_number": productsNumber,
        "view_count": viewCount,
        "commission_status": commissionStatus,
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
