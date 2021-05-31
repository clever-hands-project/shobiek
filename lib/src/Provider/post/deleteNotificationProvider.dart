import 'package:dio/dio.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/post/deletNotificationModel.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class DeletNotificationProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  DeleteNotificationModel deleteNotificationModel;
  CustomDialog dialog = CustomDialog();

  deletNot(int id, int index, BuildContext context) async {
    Map<String, String> headers = {
      // 'Authorization': 'Bearer $token',
      "X-localization": localization.currentLanguage.toString(),
    };
    FormData formData = FormData.fromMap({});

    Response response = await _utils.post("delete-notification/$id",
        body: formData, headerss: headers);
    if (response.statusCode == 200) {
      print("delete_notifications data sucsseful");
      deleteNotificationModel = DeleteNotificationModel.fromJson(response.data);
    } else {
      print("error delete_notifications data");
      deleteNotificationModel = DeleteNotificationModel.fromJson(response.data);
    }
    if (deleteNotificationModel.code == 200) {
      print("done");
      CustomAlert()
          .toast(context: context, title: "تم الحذف");
      notifyListeners();

      return true;
    } else {
      print("done");
      print('error delete_notifications');
    }
  }
}
