import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/DriverModel/AcceptOfferModle.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class SendtOfferProvider with ChangeNotifier {
  bool acceptOffer = false;
  NetworkUtil _utils = new NetworkUtil();
  AcceptOferModel cancelOfferModel;
  CustomDialog dialog = CustomDialog();
  String price;
  String offerDetails;
  sendOffer(
    int orderID,
    BuildContext context,
  ) async {
    Map<String, String> headers = {};
    FormData formData = FormData.fromMap({
      "price": price,
      "offer_details": offerDetails,
    });
    Response response = await _utils.post("driver-offer-price/$orderID",
        body: formData, headerss: headers);
    if (response == null) {
      print('error driver-offer-price');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get driver-offer-price sucsseful");
      cancelOfferModel = AcceptOferModel.fromJson(response.data);
    } else {
      print("error get driver-offer-price data");
      cancelOfferModel = AcceptOferModel.fromJson(response.data);
    }
    if (cancelOfferModel.code == 200) {
      acceptOffer = false;
      notifyListeners();
      return true;
    } else {
      print('error accept-offer');
      acceptOffer = false;
      CustomAlert().toast(context: context, title: localization.text("error"));
    }
    notifyListeners();
  }
}
