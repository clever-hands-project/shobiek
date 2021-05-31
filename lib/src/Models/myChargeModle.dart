// To parse this JSON data, do
//
//     final myChargeModel = myChargeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyChargeModel myChargeModelFromJson(String str) => MyChargeModel.fromJson(json.decode(str));

String myChargeModelToJson(MyChargeModel data) => json.encode(data.toJson());

class MyChargeModel {
    MyChargeModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Datum> error;

    factory MyChargeModel.fromJson(Map<String, dynamic> json) => MyChargeModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : List<Datum>.from(json["error"].map((x) => Datum.fromJson(x))),
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
        @required this.value,
    });

    String key;
    String value;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
    };
}
