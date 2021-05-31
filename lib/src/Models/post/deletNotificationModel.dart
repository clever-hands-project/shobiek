// To parse this JSON data, do
//
//     final deleteNotificationModel = deleteNotificationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteNotificationModel deleteNotificationModelFromJson(String str) => DeleteNotificationModel.fromJson(json.decode(str));

String deleteNotificationModelToJson(DeleteNotificationModel data) => json.encode(data.toJson());

class DeleteNotificationModel {
    DeleteNotificationModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory DeleteNotificationModel.fromJson(Map<String, dynamic> json) => DeleteNotificationModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        @required this.id,
        @required this.title,
        @required this.message,
        @required this.orderId,
        @required this.offerId,
        @required this.paymentId,
        @required this.type,
        @required this.createdAt,
    });

    int id;
    String title;
    String message;
    int orderId;
    dynamic offerId;
    dynamic paymentId;
    int type;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        message: json["message"] == null ? null : json["message"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        offerId: json["offer_id"],
        paymentId: json["payment_id"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "message": message == null ? null : message,
        "order_id": orderId == null ? null : orderId,
        "offer_id": offerId,
        "payment_id": paymentId,
        "type": type == null ? null : type,
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
