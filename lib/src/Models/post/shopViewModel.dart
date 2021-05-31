// To parse this JSON data, do
//
//     final shopViewModel = shopViewModelFromJson(jsonString);

import 'dart:convert';

ShopViewModel shopViewModelFromJson(String str) => ShopViewModel.fromJson(json.decode(str));

String shopViewModelToJson(ShopViewModel data) => json.encode(data.toJson());

class ShopViewModel {
    ShopViewModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
    dynamic error;

    factory ShopViewModel.fromJson(Map<String, dynamic> json) => ShopViewModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
        error: json["error"],
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
