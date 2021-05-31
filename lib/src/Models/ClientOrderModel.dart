// To parse this JSON data, do
//
//     final clientOrderModle = clientOrderModleFromJson(jsonString);

import 'dart:convert';

ClientOrderModle clientOrderModleFromJson(String str) => ClientOrderModle.fromJson(json.decode(str));

String clientOrderModleToJson(ClientOrderModle data) => json.encode(data.toJson());

class ClientOrderModle {
    ClientOrderModle({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<ClientOrder> data;
   List<Error> error;

    factory ClientOrderModle.fromJson(Map<String, dynamic> json) => ClientOrderModle(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<ClientOrder>.from(json["data"].map((x) => ClientOrder.fromJson(x))),
             error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
    };
}

class ClientOrder {
    ClientOrder({
        this.id,
        this.userId,
        this.user,
        this.userPhone,
        this.userPhoto,
        this.driverId,
        this.driver,
        this.driverPhone,
        this.driverPhoto,
        this.carType,
        this.shopId,
        this.shop,
        this.shopPhone,
        this.shopPhoto,
        this.orderDetails,
        this.addressDetails,
        this.orderLatitude,
        this.orderLongitude,
        this.latitude,
        this.longitude,
        this.price,
        this.orderPrice,
        this.totalPrice,
        this.status,
        this.paid,
        this.productsCart,
        this.orderTime,
        this.createdAt,
    });

    int id;
    int userId;
    String user;
    String userPhone;
    dynamic userPhoto;
    int driverId;
    String driver;
    String driverPhone;
    String driverPhoto;
    int carType;
    int shopId;
    String shop;
    String shopPhone;
    String shopPhoto;
    String orderDetails;
    String addressDetails;
    String orderLatitude;
    String orderLongitude;
    String latitude;
    String longitude;
    String price;
    String orderPrice;
    String totalPrice;
    int status;
    dynamic paid;
    List<ProductsCart> productsCart;
    DateTime orderTime;
    DateTime createdAt;

    factory ClientOrder.fromJson(Map<String, dynamic> json) => ClientOrder(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        userPhoto: json["user_photo"],
        driverId: json["driver_id"] == null ? null : json["driver_id"],
        driver: json["driver"] == null ? null : json["driver"],
        driverPhone: json["driver_phone"] == null ? null : json["driver_phone"],
        driverPhoto: json["driver_photo"] == null ? null : json["driver_photo"],
        carType: json["car_type"] == null ? null : json["car_type"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        shop: json["shop"] == null ? null : json["shop"],
        shopPhone: json["shop_phone"] == null ? null : json["shop_phone"],
        shopPhoto: json["shop_photo"] == null ? null : json["shop_photo"],
        orderDetails: json["order_details"] == null ? null : json["order_details"],
        addressDetails: json["address_details"] == null ? null : json["address_details"],
        orderLatitude: json["order_latitude"] == null ? null : json["order_latitude"],
        orderLongitude: json["order_longitude"] == null ? null : json["order_longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        price: json["price"] == null ? null : json["price"],
        orderPrice: json["order_price"] == null ? null : json["order_price"],
        totalPrice: json["total_price"] == null ? null : json["total_price"],
        status: json["status"] == null ? null : json["status"],
        paid: json["paid"],
        productsCart: json["products_cart"] == null ? null : List<ProductsCart>.from(json["products_cart"].map((x) => ProductsCart.fromJson(x))),
        orderTime: json["order_time"] == null ? null : DateTime.parse(json["order_time"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "user_phone": userPhone == null ? null : userPhone,
        "user_photo": userPhoto,
        "driver_id": driverId == null ? null : driverId,
        "driver": driver == null ? null : driver,
        "driver_phone": driverPhone == null ? null : driverPhone,
        "driver_photo": driverPhoto == null ? null : driverPhoto,
        "car_type": carType == null ? null : carType,
        "shop_id": shopId == null ? null : shopId,
        "shop": shop == null ? null : shop,
        "shop_phone": shopPhone == null ? null : shopPhone,
        "shop_photo": shopPhoto == null ? null : shopPhoto,
        "order_details": orderDetails == null ? null : orderDetails,
        "address_details": addressDetails == null ? null : addressDetails,
        "order_latitude": orderLatitude == null ? null : orderLatitude,
        "order_longitude": orderLongitude == null ? null : orderLongitude,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "price": price == null ? null : price,
        "order_price": orderPrice == null ? null : orderPrice,
        "total_price": totalPrice == null ? null : totalPrice,
        "status": status == null ? null : status,
        "paid": paid,
        "products_cart": productsCart == null ? null : List<dynamic>.from(productsCart.map((x) => x.toJson())),
        "order_time": orderTime == null ? null : orderTime.toIso8601String(),
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    };
}

class ProductsCart {
    ProductsCart({
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
    int orderId;
    String price;
    int quantity;
    int state;
    DateTime createdAt;

    factory ProductsCart.fromJson(Map<String, dynamic> json) => ProductsCart(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        productName: json["product_name"] == null ? null : json["product_name"],
        photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        shopName: json["shop_name"] == null ? null : json["shop_name"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        price: json["price"] == null ? null : json["price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        state: json["state"] == null ? null : json["state"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "product_name": productName == null ? null : productName,
        "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
        "user_id": userId == null ? null : userId,
        "user_name": userName == null ? null : userName,
        "shop_id": shopId == null ? null : shopId,
        "shop_name": shopName == null ? null : shopName,
        "order_id": orderId == null ? null : orderId,
        "price": price == null ? null : price,
        "quantity": quantity == null ? null : quantity,
        "state": state == null ? null : state,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
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
