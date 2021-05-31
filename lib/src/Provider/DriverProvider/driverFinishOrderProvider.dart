import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Helpers/route.dart';
import 'package:shobek/src/MainScreens/driver/driverMainPage.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/DriverModel/driverFinishOrderModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class DriverFinishOrderProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  DriverFinishOrderModel finishOrderModle;
  finishOrder(int orderId, BuildContext context) async {
    Map<String, String> headers = {};
    Response response = await _utils.get(
      "driver-finish-order/$orderId",
      headerss: headers,
    );

    if (response.statusCode == 200) {
      print("get driver-finish-order sucsseful");
      finishOrderModle = DriverFinishOrderModel.fromJson(response.data);
    } else {
      print("error get driver-finish-order data");
      finishOrderModle = DriverFinishOrderModel.fromJson(response.data);
    }
    if (finishOrderModle.code == 200) {
      CustomAlert().toast(context: context, title: "تم أنهاء الطلب بنجاح");
      pushAndRemoveUntil(context, DriverMainPage());
    } else {
      print('error driver-finish-order');
      CustomAlert().toast(
        context: context,
        title: finishOrderModle.error[0].value,
      );
    }
  }
}
