// To parse this JSON data, do
//
//     final getCartModel = getCartModelFromJson(jsonString);

import 'dart:convert';

GetCartModel getCartModelFromJson(String str) =>
    GetCartModel.fromJson(json.decode(str));

String getCartModelToJson(GetCartModel data) => json.encode(data.toJson());

class GetCartModel {
  GetCartModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  final List<Error> error;

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
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
    this.id,
    this.productId,
    this.productName,
    this.photos,
    this.userId,
    this.userName,
    this.shopId,
    this.shopName,
    this.orderId,
    this.price,
    this.quantity,
    this.state,
    this.createdAt,
  });

  int id;
  int productId;
  String productName;
  List<Photo> photos;
  int userId;
  String userName;
  int shopId;
  String shopName;
  dynamic orderId;
  String price;
  int quantity;
  String state;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        userId: json["user_id"],
        userName: json["user_name"],
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        orderId: json["order_id"],
        price: json["price"],
        quantity: json["quantity"],
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "user_id": userId,
        "user_name": userName,
        "shop_id": shopId,
        "shop_name": shopName,
        "order_id": orderId,
        "price": price,
        "quantity": quantity,
        "state": state,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}

class Photo {
  Photo({
    this.id,
    this.productId,
    this.photo,
    this.createdAt,
  });

  int id;
  int productId;
  String photo;
  DateTime createdAt;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        productId: json["product_id"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "photo": photo,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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
