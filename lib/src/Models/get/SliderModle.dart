// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
    SliderModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<SliderItems> data;
    List<Error> error;

    factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<SliderItems>.from(json["data"].map((x) => SliderItems.fromJson(x))),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class SliderItems {
    SliderItems({
        @required this.id,
        @required this.photo,
        @required this.providerId,
        @required this.provider,
        @required this.url,
        @required this.createdAt,
    });

    int id;
    String photo;
    int providerId;
    String provider;
    String url;
    DateTime createdAt;

    factory SliderItems.fromJson(Map<String, dynamic> json) => SliderItems(
        id: json["id"] == null ? null : json["id"],
        photo: json["photo"] == null ? null : json["photo"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        provider: json["provider"] == null ? null : json["provider"],
        url: json["url"] == null ? null : json["url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "photo": photo == null ? null : photo,
        "provider_id": providerId == null ? null : providerId,
        "provider": provider == null ? null : provider,
        "url": url == null ? null : url,
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
