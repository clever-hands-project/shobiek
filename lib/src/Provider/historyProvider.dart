import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/historyModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class HistoryProvider with ChangeNotifier {
  List<History> _history = [];

  List<History> get history {
    return [..._history];
  }

  NetworkUtil _utils = new NetworkUtil();
  HistoryModel driverOrdersModel;
  Future<HistoryModel> getHistory(
      String token, String orderType, BuildContext context) async {
    final List<History> loadedOrders = [];

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response = await _utils.get("my-history",
         headerss: headers);
    if (response.statusCode == 200) {
      print("get products-orders sucsseful");

      driverOrdersModel = HistoryModel.fromJson(response.data);
      driverOrdersModel.data.forEach((e) {
        loadedOrders.add(History(
          id: e.id,
          createdAt: e.createdAt,
          theAmount: e.theAmount,
          title: e.title,
          user: e.user,
          userId: e.userId,
        ));
      });
      _history = loadedOrders.reversed.toList();
      notifyListeners();
      return HistoryModel.fromJson(response.data);
    } else {
      print("error get products-orders data");
      driverOrdersModel = HistoryModel.fromJson(response.data);

      _history = loadedOrders.reversed.toList();
      notifyListeners();
      return HistoryModel.fromJson(response.data);
    }
  }
}
