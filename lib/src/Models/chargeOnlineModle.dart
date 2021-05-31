// To parse this JSON data, do
//
//     final chargeOnlineModel = chargeOnlineModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChargeOnlineModel chargeOnlineModelFromJson(String str) => ChargeOnlineModel.fromJson(json.decode(str));

String chargeOnlineModelToJson(ChargeOnlineModel data) => json.encode(data.toJson());

class ChargeOnlineModel {
    ChargeOnlineModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory ChargeOnlineModel.fromJson(Map<String, dynamic> json) => ChargeOnlineModel(
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
        @required this.key,
        @required this.paymentUrl,
    });

    String key;
    String paymentUrl;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        key: json["key"] == null ? null : json["key"],
        paymentUrl: json["payment_url"] == null ? null : json["payment_url"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "payment_url": paymentUrl == null ? null : paymentUrl,
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
