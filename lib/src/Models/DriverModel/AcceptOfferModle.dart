// To parse this JSON data, do
//
//     final acceptOferModel = acceptOferModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AcceptOferModel acceptOferModelFromJson(String str) => AcceptOferModel.fromJson(json.decode(str));

String acceptOferModelToJson(AcceptOferModel data) => json.encode(data.toJson());

class AcceptOferModel {
    AcceptOferModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Error> error;

    factory AcceptOferModel.fromJson(Map<String, dynamic> json) => AcceptOferModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        @required this.id,
        @required this.userId,
        @required this.user,
        @required this.userPhone,
        @required this.driverId,
        @required this.driver,
        @required this.driverPhoto,
        @required this.driverPrice,
        @required this.offerDetails,
        @required this.carType,
        @required this.driverPhone,
        @required this.orderId,
        @required this.status,
        @required this.createdAt,
    });

    int id;
    int userId;
    String user;
    String userPhone;
    int driverId;
    String driver;
    String driverPhoto;
    String driverPrice;
    String offerDetails;
    int carType;
    String driverPhone;
    int orderId;
    int status;
    DateTime createdAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        driver: json["driver"] == null ? null : json["driver"],
        driverPhoto: json["driver_photo"] == null ? null : json["driver_photo"],
        driverPrice: json["driver_price"] == null ? null : json["driver_price"],
        offerDetails: json["offer_details"] == null ? null : json["offer_details"],
        carType: json["car_type"] == null ? null : json["car_type"],
        driverPhone: json["driver_phone"] == null ? null : json["driver_phone"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "user_phone": userPhone == null ? null : userPhone,
        "driver_id": driverId == null ? null : driverId,
        "driver": driver == null ? null : driver,
        "driver_photo": driverPhoto == null ? null : driverPhoto,
        "driver_price": driverPrice == null ? null : driverPrice,
        "offer_details": offerDetails == null ? null : offerDetails,
        "car_type": carType == null ? null : carType,
        "driver_phone": driverPhone == null ? null : driverPhone,
        "order_id": orderId == null ? null : orderId,
        "status": status == null ? null : status,
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
