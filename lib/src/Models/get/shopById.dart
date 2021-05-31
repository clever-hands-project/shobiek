// To parse this JSON data, do
//
//     final shopByIdModel = shopByIdModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ShopByIdModel shopByIdModelFromJson(String str) => ShopByIdModel.fromJson(json.decode(str));

String shopByIdModelToJson(ShopByIdModel data) => json.encode(data.toJson());

class ShopByIdModel {
    ShopByIdModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    ShopById data;
    List<Error> error;

    factory ShopByIdModel.fromJson(Map<String, dynamic> json) => ShopByIdModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : ShopById.fromJson(json["data"]),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class ShopById {
    ShopById({
        @required this.id,
        @required this.name,
        @required this.phoneNumber,
        @required this.countryCode,
        @required this.photo,
        @required this.photos,
        @required this.active,
        @required this.type,
        @required this.details,
        @required this.longitude,
        @required this.latitude,
        @required this.address,
        @required this.cityId,
        @required this.city,
        @required this.regionId,
        @required this.region,
        @required this.departmentId,
        @required this.department,
        @required this.productsNumber,
        @required this.viewCount,
        @required this.commissionStatus,
        @required this.openTime,
        @required this.closeTime,
        @required this.favorite,
        @required this.apiToken,
        @required this.createdAt,
    });

    int id;
    String name;
    String phoneNumber;
    int countryCode;
    String photo;
    List<Photo> photos;
    int active;
    int type;
    String details;
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
    String openTime;
    String closeTime;
    int favorite;
    String apiToken;
    DateTime createdAt;

    factory ShopById.fromJson(Map<String, dynamic> json) => ShopById(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        photo: json["photo"] == null ? null : json["photo"],
        photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        active: json["active"] == null ? null : json["active"],
        type: json["type"] == null ? null : json["type"],
        details: json["details"] == null ? null : json["details"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        address: json["address"] == null ? null : json["address"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        city: json["city"] == null ? null : json["city"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        region: json["region"] == null ? null : json["region"],
        departmentId: json["department_id"] == null ? null : json["department_id"],
        department: json["department"] == null ? null : json["department"],
        productsNumber: json["products_number"] == null ? null : json["products_number"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
        commissionStatus: json["commission_status"] == null ? null : json["commission_status"],
        openTime: json["open_time"] == null ? null : json["open_time"],
        closeTime: json["close_time"] == null ? null : json["close_time"],
        favorite: json["favorite"] == null ? null : json["favorite"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "country_code": countryCode == null ? null : countryCode,
        "photo": photo == null ? null : photo,
        "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
        "active": active == null ? null : active,
        "type": type == null ? null : type,
        "details": details == null ? null : details,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "address": address == null ? null : address,
        "city_id": cityId == null ? null : cityId,
        "city": city == null ? null : city,
        "region_id": regionId == null ? null : regionId,
        "region": region == null ? null : region,
        "department_id": departmentId == null ? null : departmentId,
        "department": department == null ? null : department,
        "products_number": productsNumber == null ? null : productsNumber,
        "view_count": viewCount == null ? null : viewCount,
        "commission_status": commissionStatus == null ? null : commissionStatus,
        "open_time": openTime == null ? null : openTime,
        "close_time": closeTime == null ? null : closeTime,
        "favorite": favorite == null ? null : favorite,
        "api_token": apiToken == null ? null : apiToken,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    };
}

class Photo {
    Photo({
        @required this.id,
        @required this.shopId,
        @required this.photo,
        @required this.createdAt,
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

class Error {
    Error({
        @required this.key,
        @required this.value,
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
