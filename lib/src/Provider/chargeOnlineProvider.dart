import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/Wallet/online_payment.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/chargeOnlineModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ChargeOnlineProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  ChargeOnlineModel subscribeModel;
  subscribe(String token, String price, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    FormData formData = FormData.fromMap({
      "cash": price,
    });

    Response response = await _utils.post("charge-electronic-pocket",
        body: formData, headerss: headers);

    if (response.statusCode == 200) {
      print("pay electronic sucsseful");
      subscribeModel = ChargeOnlineModel.fromJson(response.data);
    } else {
      print("error  electronic data");
      subscribeModel = ChargeOnlineModel.fromJson(response.data);
    }
    if (subscribeModel.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => OnlinePaymentScreen(
                      url: subscribeModel.data[0].paymentUrl,
                    )));
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      print('error pay');
      CustomAlert()
          .toast(title: subscribeModel.error[0].value, context: context);
    }
  }
}
