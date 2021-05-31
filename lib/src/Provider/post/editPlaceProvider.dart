import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/post/createPlaceModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class EditPlaceProvider with ChangeNotifier {
  String placeDetails;
  String placeName;
  String longitude;
  String latitude;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  CreatePlaceModel _model;
  setNull() {
    placeDetails = null;
    placeName = null;
    longitude = null;
    latitude = null;
    notifyListeners();
  }

  createPlace( String id, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();

    FormData formData = FormData.fromMap({
      "place_name": placeName,
      "place_details": placeDetails,
      "longitude": longitude,
      "latitude": latitude,
    });

    Response response =
        await _utils.post("edit-place/$id", body: formData, );
    if (response == null) {
      print('error edit-place res == null');
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showWarningDialog(
          btnOnPress: () {},
          context: context,
          msg: localization.text("internet"),
        );
      });
      return;
    }
    if (response.statusCode == 200) {
      print("edit-place sucsseful");
      _model = CreatePlaceModel.fromJson(response.data);
    } else {
      print("error edit-place");
      _model = CreatePlaceModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      CustomAlert().toast(
        context: context,
        title: "تم التعديل",
      );
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });

      setNull();
      notifyListeners();
      return true;
    } else {
      print('error edit-order');
      _model = CreatePlaceModel.fromJson(response.data);
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
            btnOnPress: () {},
            context: context,
            msg: _model.error[0].value,
            ok: localization.text("ok"),
            code: _model.code);
      });
    }
    notifyListeners();
  }
}
