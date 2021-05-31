// To parse this JSON data, do
//
//     final createMessageModel = createMessageModelFromJson(jsonString);

import 'dart:convert';

CreateMessageModel createMessageModelFromJson(String str) => CreateMessageModel.fromJson(json.decode(str));

String createMessageModelToJson(CreateMessageModel data) => json.encode(data.toJson());

class CreateMessageModel {
    CreateMessageModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory CreateMessageModel.fromJson(Map<String, dynamic> json) => CreateMessageModel(
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
        this.id,
        this.first,
        this.second,
        this.firstOnline,
        this.secondOnline,
        this.seen,
        this.createdAt,
    });

    int id;
    int first;
    int second;
    int firstOnline;
    int secondOnline;
    int seen;
    String createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        first: json["first"] == null ? null : json["first"],
        second: json["second"] == null ? null : json["second"],
        firstOnline: json["first_online"] == null ? null : json["first_online"],
        secondOnline: json["second_online"] == null ? null : json["second_online"],
        seen: json["seen"] == null ? null : json["seen"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first": first == null ? null : first,
        "second": second == null ? null : second,
        "first_online": firstOnline == null ? null : firstOnline,
        "second_online": secondOnline == null ? null : secondOnline,
        "seen": seen == null ? null : seen,
        "created_at": createdAt == null ? null : createdAt,
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
