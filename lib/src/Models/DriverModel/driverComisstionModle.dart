// To parse this JSON data, do
//
//     final driverCommistionModle = driverCommistionModleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DriverCommistionModle driverCommistionModleFromJson(String str) => DriverCommistionModle.fromJson(json.decode(str));

String driverCommistionModleToJson(DriverCommistionModle data) => json.encode(data.toJson());

class DriverCommistionModle {
    DriverCommistionModle({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    int mainCode;
    int code;
    List<DriverCommitions> data;
    List<Error> error;

    factory DriverCommistionModle.fromJson(Map<String, dynamic> json) => DriverCommistionModle(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<DriverCommitions>.from(json["data"].map((x) => DriverCommitions.fromJson(x))),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class DriverCommitions {
    DriverCommitions({
        @required this.commissions,
        @required this.totalCommissions,
        @required this.totalPaidCommissions,
        @required this.totalUnpaidCommissions,
    });

    List<Commission> commissions;
    String totalCommissions;
    String totalPaidCommissions;
    String totalUnpaidCommissions;

    factory DriverCommitions.fromJson(Map<String, dynamic> json) => DriverCommitions(
        commissions: json["commissions"] == null ? null : List<Commission>.from(json["commissions"].map((x) => Commission.fromJson(x))),
        totalCommissions: json["total_commissions"] == null ? null : json["total_commissions"],
        totalPaidCommissions: json["total_paid_commissions"] == null ? null : json["total_paid_commissions"],
        totalUnpaidCommissions: json["total_unpaid_commissions"] == null ? null : json["total_unpaid_commissions"],
    );

    Map<String, dynamic> toJson() => {
        "commissions": commissions == null ? null : List<dynamic>.from(commissions.map((x) => x.toJson())),
        "total_commissions": totalCommissions == null ? null : totalCommissions,
        "total_paid_commissions": totalPaidCommissions == null ? null : totalPaidCommissions,
        "total_unpaid_commissions": totalUnpaidCommissions == null ? null : totalUnpaidCommissions,
    };
}

class Commission {
    Commission({
        @required this.id,
        @required this.commission,
        @required this.orderId,
        @required this.price,
        @required this.userId,
        @required this.user,
        @required this.orderPrice,
        @required this.totalOrder,
        @required this.shopId,
        @required this.shop,
        @required this.commissionStatus,
        @required this.createdAt,
    });

    int id;
    String commission;
    int orderId;
    String price;
    int userId;
    String user;
    String orderPrice;
    String totalOrder;
    int shopId;
    String shop;
    int commissionStatus;
    DateTime createdAt;

    factory Commission.fromJson(Map<String, dynamic> json) => Commission(
        id: json["id"] == null ? null : json["id"],
        commission: json["commission"] == null ? null : json["commission"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        price: json["price"] == null ? null : json["price"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        orderPrice: json["order_price"] == null ? null : json["order_price"],
        totalOrder: json["total_order"] == null ? null : json["total_order"],
        shopId: json["shop_id"] == null ? null : json["shop_id"],
        shop: json["shop"] == null ? null : json["shop"],
        commissionStatus: json["commission_status"] == null ? null : json["commission_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "commission": commission == null ? null : commission,
        "order_id": orderId == null ? null : orderId,
        "price": price == null ? null : price,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "order_price": orderPrice == null ? null : orderPrice,
        "total_order": totalOrder == null ? null : totalOrder,
        "shop_id": shopId == null ? null : shopId,
        "shop": shop == null ? null : shop,
        "commission_status": commissionStatus == null ? null : commissionStatus,
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
