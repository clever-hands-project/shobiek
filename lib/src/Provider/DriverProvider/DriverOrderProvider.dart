import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/DriverModel/DriverOrderModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class DriverOrdersProvider with ChangeNotifier {
  List<DriverOrder> _driverOrders = [];

  List<DriverOrder> get driverOrders {
    return [..._driverOrders];
  }

  clear() {
    _driverOrders = [];
    notifyListeners();
  }

  NetworkUtil _utils = new NetworkUtil();
  DriverOrderModle driverOrdersModel;
  Future<DriverOrderModle> getDriverOrders(
      String token, String orderType, BuildContext context) async {
    final List<DriverOrder> loadedOrders = [];

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({"order_type": orderType});
    Response response = await _utils.post("driver-orders", 
        body: formData, headerss: headers);
    if (response.statusCode == 200) {
      print("get driver-orders sucsseful");

      driverOrdersModel = DriverOrderModle.fromJson(response.data);
      driverOrdersModel.data.forEach((e) {
        loadedOrders.add(DriverOrder(
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
      _driverOrders = loadedOrders.reversed.toList();
      notifyListeners();
      return DriverOrderModle.fromJson(response.data);
    } else {
      print("error get driver-orders data");
      driverOrdersModel = DriverOrderModle.fromJson(response.data);

      _driverOrders = loadedOrders.reversed.toList();
      notifyListeners();
      return DriverOrderModle.fromJson(response.data);
    }
  }
}
