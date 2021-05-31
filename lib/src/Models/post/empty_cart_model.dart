// To parse this JSON data, do
//
//     final emptyCartModel = emptyCartModelFromJson(jsonString);

import 'dart:convert';

EmptyCartModel emptyCartModelFromJson(String str) =>
    EmptyCartModel.fromJson(json.decode(str));

String emptyCartModelToJson(EmptyCartModel data) => json.encode(data.toJson());

class EmptyCartModel {
  EmptyCartModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  final List<Error> error;

  factory EmptyCartModel.fromJson(Map<String, dynamic> json) => EmptyCartModel(
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
  Data({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
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
