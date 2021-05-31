// To parse this JSON data, do
//
//     final departmentsModel = departmentsModelFromJson(jsonString);

import 'dart:convert';

DepartmentsModel departmentsModelFromJson(String str) =>
    DepartmentsModel.fromJson(json.decode(str));

String departmentsModelToJson(DepartmentsModel data) =>
    json.encode(data.toJson());

class DepartmentsModel {
  DepartmentsModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Department> data;
  dynamic error;

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) =>
      DepartmentsModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Department>.from(
                json["data"].map((x) => Department.fromJson(x))),
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

class Department {
  Department({
    this.id,
    this.name,
    this.photo,
    this.createdAt,
  });

  int id;
  String name;
  String photo;
  DateTime createdAt;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
