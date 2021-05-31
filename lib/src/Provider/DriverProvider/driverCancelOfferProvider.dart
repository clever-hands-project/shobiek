import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/DriverModel/driverCancelOfferModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class DriverCancelOfferProvider with ChangeNotifier {
  bool cancelOffer = false;
  NetworkUtil _utils = new NetworkUtil();
  DriverCancelOfferModel cancelOfferModel;
  CustomDialog dialog = CustomDialog();

  cancleOffer(
    int orderID,
    BuildContext context,
  ) async {
    Map<String, String> headers = {};
    Response response = await _utils.get("delete-offer/$orderID", headerss: headers);
    if (response == null) {
      print('error delete-offer');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get delete-offer sucsseful");
      cancelOfferModel = DriverCancelOfferModel.fromJson(response.data);
    } else {
      print("error get delete-offer data");
      cancelOfferModel = DriverCancelOfferModel.fromJson(response.data);
    }
    if (cancelOfferModel.code == 200) {
      cancelOffer = false;
      notifyListeners();
      return true;
    } else {
      print('error accept-offer');
      cancelOffer = false;
      CustomAlert().toast(context: context, title: localization.text("error"));
    }
    notifyListeners();
  }
}
