// To parse this JSON data, do
//
//     final deletePhotoModel = deletePhotoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeletePhotoModel deletePhotoModelFromJson(String str) => DeletePhotoModel.fromJson(json.decode(str));

String deletePhotoModelToJson(DeletePhotoModel data) => json.encode(data.toJson());

class DeletePhotoModel {
    DeletePhotoModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Data> error;

    factory DeletePhotoModel.fromJson(Map<String, dynamic> json) => DeletePhotoModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : List<Data>.from(json["error"].map((x) => Data.fromJson(x))),
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
        @required this.key,
        @required this.value,
    });

    String key;
    String value;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
    };
}
