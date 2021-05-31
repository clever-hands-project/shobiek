// To parse this JSON data, do
//
//     final servicesCatogoryModel = servicesCatogoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServicesCatogoryModel servicesCatogoryModelFromJson(String str) => ServicesCatogoryModel.fromJson(json.decode(str));

String servicesCatogoryModelToJson(ServicesCatogoryModel data) => json.encode(data.toJson());

class ServicesCatogoryModel {
    ServicesCatogoryModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<ServicesCatogor> data;
    List<Error> error;

    factory ServicesCatogoryModel.fromJson(Map<String, dynamic> json) => ServicesCatogoryModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<ServicesCatogor>.from(json["data"].map((x) => ServicesCatogor.fromJson(x))),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class ServicesCatogor {
    ServicesCatogor({
        @required this.id,
        @required this.name,
        @required this.createdAt,
    });

    int id;
    String name;
    DateTime createdAt;

    factory ServicesCatogor.fromJson(Map<String, dynamic> json) => ServicesCatogor(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
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
