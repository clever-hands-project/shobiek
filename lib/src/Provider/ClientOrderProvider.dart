import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

import '../Models/ClientOrderModel.dart';

class ClientOrdersProvider with ChangeNotifier {
  List<ClientOrder> _clientOrders = [];

  List<ClientOrder> get clientOrders {
    return [..._clientOrders];
  }

  clear() {
    _clientOrders = [];
    notifyListeners();
  }

  NetworkUtil _utils = new NetworkUtil();
  ClientOrderModle driverOrdersModel;
  Future<ClientOrderModle> getClientOrders(
    int orderType, BuildContext context) async {
    final List<ClientOrder> loadedOrders = [];

    FormData formData = FormData.fromMap({"order_type": orderType});
    Response response = await _utils.post("client-orders",
        body: formData, );
    if (response.statusCode == 200) {
      print("get client-orders sucsseful");
      driverOrdersModel = ClientOrderModle.fromJson(response.data);
      driverOrdersModel.data.forEach((e) {
        loadedOrders.add(ClientOrder(
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
          orderTime: e.orderTime??DateTime.now().subtract(Duration(minutes:5)),
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
      _clientOrders = loadedOrders.reversed.toList();
      notifyListeners();
      return ClientOrderModle.fromJson(response.data);
    } else {
      print("error get  client-orders data");
      driverOrdersModel = ClientOrderModle.fromJson(response.data);

      _clientOrders = loadedOrders.reversed.toList();
      notifyListeners();
      return ClientOrderModle.fromJson(response.data);
    }
  }
}
