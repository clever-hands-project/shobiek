// To parse this JSON data, do
//
//     final shopProducts = shopProductsFromJson(jsonString);

import 'dart:convert';

ShopProductsModle shopProductsFromJson(String str) =>
    ShopProductsModle.fromJson(json.decode(str));

String shopProductsToJson(ShopProductsModle data) => json.encode(data.toJson());

class ShopProductsModle {
  ShopProductsModle({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<ProductsShop> data;
  dynamic error;

  factory ShopProductsModle.fromJson(Map<String, dynamic> json) =>
      ShopProductsModle(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<ProductsShop>.from(
                json["data"].map((x) => ProductsShop.fromJson(x))),
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

class ProductsShop {
  ProductsShop({
    this.id,
    this.name,
    this.details,
    this.photos,
    this.price,
    this.available,
    this.shopId,
    this.shop,
    this.categoryId,
    this.category,
    this.createdAt,
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

  factory ProductsShop.fromJson(Map<String, dynamic> json) => ProductsShop(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        details: json["details"] == null ? null : json["details"],
        photos: json["photos"] == null
            ? null
            : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        price: json["price"] == null ? null : json["price"],
        available: json["available"] == null ? null : json["available"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        shop: json["shop"] == null ? null : json["shop"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        category: json["category"] == null ? null : json["category"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "details": details == null ? null : details,
        "photos": photos == null
            ? null
            : List<dynamic>.from(photos.map((x) => x.toJson())),
        "price": price == null ? null : price,
        "available": available == null ? null : available,
        "shop_id": shopId == null ? null : shopId,
        "shop": shop == null ? null : shop,
        "category_id": categoryId == null ? null : categoryId,
        "category": category == null ? null : category,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        photo: json["photo"] == null ? null : json["photo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "photo": photo == null ? null : photo,
        "created_at": createdAt == null
            ? null
            : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
