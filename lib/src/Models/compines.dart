// To parse this JSON data, do
//
//     final helpCenterModel = helpCenterModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Complaint helpCenterModelFromJson(String str) => Complaint.fromJson(json.decode(str));

String helpCenterModelToJson(Complaint data) => json.encode(data.toJson());

class Complaint {
    Complaint({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Error> error;

    factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
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
        @required this.title,
        @required this.details,
        @required this.orderId,
        @required this.createdAt,
    });

    int id;
    int userId;
    String user;
    String title;
    String details;
    int orderId;
    DateTime createdAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        title: json["title"] == null ? null : json["title"],
        details: json["details"] == null ? null : json["details"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "title": title == null ? null : title,
        "details": details == null ? null : details,
        "order_id": orderId == null ? null : orderId,
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
