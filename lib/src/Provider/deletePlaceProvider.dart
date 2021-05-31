import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/deletPlaceModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class DeletePlaceProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  DeletePlaceDataModel deletePlaceModel;
  CustomDialog dialog = CustomDialog();

  deletePlace(
    String token,
    String id,
    BuildContext context,
  ) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};

    Response response =
        await _utils.post("delete-place/$id", headerss: headers);
    if (response == null) {
      print('error rate');
      dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: localization.text("internet"),
      );
    }
    if (response.statusCode == 200) {
      print("get delete-place sucsseful");
      deletePlaceModel = DeletePlaceDataModel.fromJson(response.data);
    } else {
      print("error get delete-place data");
      deletePlaceModel = DeletePlaceDataModel.fromJson(response.data);
    }
    if (deletePlaceModel.code == 200) {
      CustomAlert().toast(
        context: context,
        title: "تم حذف المكان",
      );
      return true;
    } else {
      print('error confirmed');
      CustomAlert().toast(
        context: context,
        title: localization.text("error"),
      );
    }
    notifyListeners();
  }
}
