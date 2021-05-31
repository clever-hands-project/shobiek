import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:shobek/src/Models/get/offers.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class OffersProvider with ChangeNotifier {
  List<Offers> _offers = [];

  List<Offers> get offers {
    return [..._offers];
  }

  NetworkUtil _utils = new NetworkUtil();
  OffersModel restourant;
  Future<OffersModel> getOffers(
      {int id, BuildContext context}) async {
    final List<Offers> loaded = [];
    Future.delayed(Duration(microseconds: 150), () {
      restourant = null;
      notifyListeners();
    });



    Response response = await _utils.get("offers/$id");

    if (response.statusCode == 200) {
      print("get offers sucsseful");

      restourant = OffersModel.fromJson(response.data);

      restourant.data.forEach((e) {
        loaded.add(
          Offers(
            id: e.id,
            carType: e.carType,
            createdAt: e.createdAt,
            driver: e.driver,
            driverId: e.driverId,
            driverPhone: e.driverPhone,
            driverPhoto: e.driverPhoto,
            driverPrice: e.driverPrice,
            orderId: e.orderId,
            status: e.status,
            user: e.user,
            userId: e.userId,
            userPhone: e.userPhone,
          ),
        );
      });
      _offers = loaded.toList();
      notifyListeners();
      return OffersModel.fromJson(response.data);
    } else {
      restourant = OffersModel.fromJson(response.data);
      _offers = loaded.toList();

      notifyListeners();

      print("error get offers data");
      return OffersModel.fromJson(response.data);
    }
  }
}
