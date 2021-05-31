// To parse this JSON data, do
//
//     final clientCancelOrder = clientCancelOrderFromJson(jsonString);

import 'dart:convert';

ClientCancelOrder clientCancelOrderFromJson(String str) =>
    ClientCancelOrder.fromJson(json.decode(str));

String clientCancelOrderToJson(ClientCancelOrder data) =>
    json.encode(data.toJson());

class ClientCancelOrder {
  ClientCancelOrder({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory ClientCancelOrder.fromJson(Map<String, dynamic> json) =>
      ClientCancelOrder(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  Datum({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
