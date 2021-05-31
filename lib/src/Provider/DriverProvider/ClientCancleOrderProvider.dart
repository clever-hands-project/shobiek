import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Helpers/route.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/DriverModel/cancelOrderModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ClientCancleOrderProvider with ChangeNotifier {
  String cancelDetails;
  NetworkUtil _utils = new NetworkUtil();
  CancelOrderModel cancelOrderModel;
  CustomDialog dialog = CustomDialog();

  cancelOrder(
    int id,
    BuildContext context,
  ) async {
    print("order $id");
    Map<String, String> headers = {};
    FormData formData = FormData.fromMap({
      "cancel_reason_driver": cancelDetails ?? "الغاء",
    });
    Response response = await _utils.post("client-cancel-order/$id",
        body: formData, headerss: headers);
    if (response == null) {
      print('error client-cancel-order');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get client-cancel-order sucsseful");
      cancelOrderModel = CancelOrderModel.fromJson(response.data);
    } else {
      print("error get client-cancel-order data");
      cancelOrderModel = CancelOrderModel.fromJson(response.data);
    }
    if (cancelOrderModel.code == 200) {
      CustomAlert().toast(context: context, title: 'تم إنهاء الطلب');
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => MainPage(index: 2,)));
          pushAndRemoveUntil(context, MainPage(index: 2,));
          
      return true;
    } else {
      print('error driver-cancel-order');
      CustomAlert()
          .toast(context: context, title: cancelOrderModel.error[0].value);
      return false;
    }
  }
}
