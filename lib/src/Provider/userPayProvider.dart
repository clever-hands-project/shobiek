import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shobek/src/MainScreens/HomeScreen/Profile/internal/Wallet/online_payment.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/userPayModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class UserPayProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  UserPayModle userPayModel;
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  userPay(
    
    int orderId,
    String payId,
    BuildContext context,
  ) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Map<String, String> headers = {};
    FormData formData = FormData.fromMap({"finish": payId});
    Response response = await _utils.post("client-finish-order/$orderId",
        body: formData, headerss: headers);
    if (response == null) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(
          context: context,
          title: "يرجي التحقق من الاتصال",
        );
      });
    }
    if (response.statusCode == 200) {
      print("get user_pay_order sucsseful");
      userPayModel = UserPayModle.fromJson(response.data);
    } else {
      print("error get user_pay_order data");
      userPayModel = UserPayModle.fromJson(response.data);
    }
    if (userPayModel.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        if (userPayModel.data.paymentUrl == null) {
          CustomAlert().toast(
            context: context,
            title: userPayModel.data.value,
          );

          Navigator.pop(context);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => OnlinePaymentScreen(
                        url: userPayModel.data.paymentUrl,
                      )));
        }
      });

      return true;
    } else {
      print('error user_pay_order');
      CustomAlert().toast(
        context: context,
        title: userPayModel.error[0].value,
      );
    }
    notifyListeners();
  }
}
