// To parse this JSON data, do
//
//     final shopHoursModel = shopHoursModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ShopHoursModel shopHoursModelFromJson(String str) => ShopHoursModel.fromJson(json.decode(str));

String shopHoursModelToJson(ShopHoursModel data) => json.encode(data.toJson());

class ShopHoursModel {
    ShopHoursModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory ShopHoursModel.fromJson(Map<String, dynamic> json) => ShopHoursModel(
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
        @required this.openTime,
        @required this.closeTime,
        @required this.day,
    });

    String openTime;
    String closeTime;
    List<Day> day;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        openTime: json["open_time"] == null ? null : json["open_time"],
        closeTime: json["close_time"] == null ? null : json["close_time"],
        day: json["day"] == null ? null : List<Day>.from(json["day"].map((x) => Day.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "open_time": openTime == null ? null : openTime,
        "close_time": closeTime == null ? null : closeTime,
        "day": day == null ? null : List<dynamic>.from(day.map((x) => x.toJson())),
    };
}

class Day {
    Day({
        @required this.day,
        @required this.dayName,
    });

    int day;
    String dayName;

    factory Day.fromJson(Map<String, dynamic> json) => Day(
        day: json["day"] == null ? null : json["day"],
        dayName: json["day_name"] == null ? null : json["day_name"],
    );

    Map<String, dynamic> toJson() => {
        "day": day == null ? null : day,
        "day_name": dayName == null ? null : dayName,
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
