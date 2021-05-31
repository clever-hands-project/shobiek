// To parse this JSON data, do
//
//     final clientFinishOrderModel = clientFinishOrderModelFromJson(jsonString);

import 'dart:convert';

ClientFinishOrderModel clientFinishOrderModelFromJson(String str) =>
    ClientFinishOrderModel.fromJson(json.decode(str));

String clientFinishOrderModelToJson(ClientFinishOrderModel data) =>
    json.encode(data.toJson());

class ClientFinishOrderModel {
  ClientFinishOrderModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory ClientFinishOrderModel.fromJson(Map<String, dynamic> json) =>
      ClientFinishOrderModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error,
      };
}

class Data {
  Data({
    this.key,
    this.paymentUrl,
  });

  String key;
  String paymentUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
