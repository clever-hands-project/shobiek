import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/shop/shopOrdersModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ShopOrderProvider with ChangeNotifier {
  List<ShopOrders> _shopOrders = [];

  List<ShopOrders> get shopOrders {
    return [..._shopOrders];
  }

  clear() {
    _shopOrders = [];
    notifyListeners();
  }

  NetworkUtil _utils = new NetworkUtil();
  ShopOrdersModel driverOrdersModel;
  Future<ShopOrdersModel> getShopOrders(
      String token, String orderType, BuildContext context) async {
    final List<ShopOrders> loadedOrders = [];

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({"order_type": orderType});
    Response response = await _utils.post("shop-orders", 
        body: formData, headerss: headers);
    if (response.statusCode == 200) {
      print("get shop-orders sucsseful");

      driverOrdersModel = ShopOrdersModel.fromJson(response.data);
      driverOrdersModel.data.forEach((e) {
        loadedOrders.add(ShopOrders(
          id: e.id,
          createdAt: e.createdAt,
          orderDetails: e.orderDetails,
          orderLatitude: e.orderLatitude,
          orderLongitude: e.orderLongitude,
          addressDetails: e.addressDetails,
          userPhoto: e.userPhoto,
          driver: e.driver,
          driverId: e.driverId,
          driverPhone: e.driverPhone,
          latitude: e.latitude,
          longitude: e.longitude,
          orderPrice: e.orderPrice,
          price: e.price,
          status: e.status,
          user: e.user,
          userPhone: e.userPhone,
          userId: e.userId,
          carType: e.carType,
          driverPhoto: e.driverPhoto,
          paid: e.paid,
          productsCart: e.productsCart,
          shop: e.shop,
          shopId: e.shopId,
          shopPhone: e.shopPhone,
          shopPhoto: e.shopPhoto,
          totalPrice: e.totalPrice,
        ));
      });
      _shopOrders = loadedOrders.reversed.toList();
      notifyListeners();
      return ShopOrdersModel.fromJson(response.data);
    } else {
      print("error get shop-orders data");
      driverOrdersModel = ShopOrdersModel.fromJson(response.data);

      _shopOrders = loadedOrders.reversed.toList();
      notifyListeners();
      return ShopOrdersModel.fromJson(response.data);
    }
  }
}
