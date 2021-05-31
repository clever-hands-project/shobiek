import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/Wallet/online_payment.dart';
import 'package:shobek/src/Models/clientFinishOrderModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ClientFinishOrderProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  ClientFinishOrderModel _model;
  clientFinishOder( int id, int type, BuildContext context) async {
    FormData formData = FormData.fromMap({"finish": type});

    Map<String, String> headers = {};
    Response response = await _utils.post("client-finish-order/$id", 
        headerss: headers, body: formData);
    if (response.statusCode == 200) {
      print("get make_ad_favrouit sucsseful");
      _model = ClientFinishOrderModel.fromJson(response.data);
    } else {
      print("error get make_ad_favrouit data");
      _model = ClientFinishOrderModel.fromJson(response.data);
    }
    if (response.statusCode == 200) {
      _model = ClientFinishOrderModel.fromJson(response.data);
      String url = _model.data.paymentUrl;
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => OnlinePaymentScreen(
                key: ValueKey(_model.data.key),
                url: url,
              )));
    }
    notifyListeners();
  }
}
