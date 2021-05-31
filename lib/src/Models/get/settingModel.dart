// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
    SettingModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    Data data;
    List<Error> error;

    factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
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
        @required this.phoneNumber,
        @required this.welcomeText,
        @required this.orderDuration,
        @required this.cancelDuration,
        @required this.pullLimit,
        @required this.chargeLimit,
    });

    String phoneNumber;
    String welcomeText;
    int orderDuration;
    int cancelDuration;
    String pullLimit;
    String chargeLimit;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        welcomeText: json["welcome_text"] == null ? null : json["welcome_text"],
        orderDuration: json["order_duration"] == null ? null : json["order_duration"],
        cancelDuration: json["cancel_duration"] == null ? null : json["cancel_duration"],
        pullLimit: json["pull_limit"] == null ? null : json["pull_limit"],
        chargeLimit: json["charge_limit"] == null ? null : json["charge_limit"],
    );

    Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "welcome_text": welcomeText == null ? null : welcomeText,
        "order_duration": orderDuration == null ? null : orderDuration,
        "cancel_duration": cancelDuration == null ? null : cancelDuration,
        "pull_limit": pullLimit == null ? null : pullLimit,
        "charge_limit": chargeLimit == null ? null : chargeLimit,
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
