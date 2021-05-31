// To parse this JSON data, do
//
//     final rogineModel = rogineModelFromJson(jsonString);

import 'dart:convert';

RogineModel rogineModelFromJson(String str) =>
    RogineModel.fromJson(json.decode(str));

String rogineModelToJson(RogineModel data) => json.encode(data.toJson());

class RogineModel {
  RogineModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Rogine> data;
  dynamic error;

  factory RogineModel.fromJson(Map<String, dynamic> json) => RogineModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Rogine>.from(json["data"].map((x) => Rogine.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Rogine {
  Rogine({
    this.id,
    this.name,
    this.createdAt,
  });

  int id;
  String name;
  DateTime createdAt;

  factory Rogine.fromJson(Map<String, dynamic> json) => Rogine(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
