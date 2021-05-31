// To parse this JSON data, do
//
//     final reportShopModel = reportShopModelFromJson(jsonString);

import 'dart:convert';

ReportShopModel reportShopModelFromJson(String str) => ReportShopModel.fromJson(json.decode(str));

String reportShopModelToJson(ReportShopModel data) => json.encode(data.toJson());

class ReportShopModel {
    ReportShopModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
     List<Error> error;

    factory ReportShopModel.fromJson(Map<String, dynamic> json) => ReportShopModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"] == null
            ? null
            :  Data.fromJson(json["data"]),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": data.toJson(),
        "error": error,
    };
}

class Data {
    Data({
        this.id,
        this.userId,
        this.user,
        this.details,
        this.shopId,
        this.createdAt,
    });

    int id;
    int userId;
    String user;
    String details;
    int shopId;
    DateTime createdAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        user: json["user"],
        details: json["details"],
        shopId: json["shop_id"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user": user,
        "details": details,
        "shop_id": shopId,
        "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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
