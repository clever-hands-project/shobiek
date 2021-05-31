// To parse this JSON data, do
//
//     final productFiltterModel = productFiltterModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductFiltterModel productFiltterModelFromJson(String str) => ProductFiltterModel.fromJson(json.decode(str));

String productFiltterModelToJson(ProductFiltterModel data) => json.encode(data.toJson());

class ProductFiltterModel {
    ProductFiltterModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<ProductFilter> data;
    List<Error> error;

    factory ProductFiltterModel.fromJson(Map<String, dynamic> json) => ProductFiltterModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<ProductFilter>.from(json["data"].map((x) => ProductFilter.fromJson(x))),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class ProductFilter {
    ProductFilter({
        @required this.id,
        @required this.name,
        @required this.details,
        @required this.photos,
        @required this.price,
        @required this.available,
        @required this.shopId,
        @required this.shop,
        @required this.categoryId,
        @required this.category,
        @required this.createdAt,
    });

    int id;
    String name;
    String details;
    List<Photo> photos;
    String price;
    int available;
    int shopId;
    String shop;
    int categoryId;
    String category;
    DateTime createdAt;

    factory ProductFilter.fromJson(Map<String, dynamic> json) => ProductFilter(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        details: json["details"] == null ? null : json["details"],
        photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        price: json["price"] == null ? null : json["price"],
        available: json["available"] == null ? null : json["available"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        shop: json["shop"] == null ? null : json["shop"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        category: json["category"] == null ? null : json["category"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "details": details == null ? null : details,
        "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
        "price": price == null ? null : price,
        "available": available == null ? null : available,
        "shop_id": shopId == null ? null : shopId,
        "shop": shop == null ? null : shop,
        "category_id": categoryId == null ? null : categoryId,
        "category": category == null ? null : category,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    };
}

class Photo {
    Photo({
        @required this.id,
        @required this.productId,
        @required this.photo,
        @required this.createdAt,
    });

    int id;
    int productId;
    String photo;
    DateTime createdAt;

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        photo: json["photo"] == null ? null : json["photo"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "photo": photo == null ? null : photo,
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
