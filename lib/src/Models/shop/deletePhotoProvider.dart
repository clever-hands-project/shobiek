import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

import 'deletePhotoModle.dart';

class DeletePhotoProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  DeletePhotoModel deleteNotificationModel;
  CustomDialog dialog = CustomDialog();

  deletNot(String token, int id, BuildContext context) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    FormData formData = FormData.fromMap({});

    Response response = await _utils.post("delete-photo/$id",
        body: formData, headerss: headers);
    if (response.statusCode == 200) {
      print("add delete-product sucsseful");
      deleteNotificationModel = DeletePhotoModel.fromJson(response.data);
    } else {
      print("error delete-product data");
      deleteNotificationModel = DeletePhotoModel.fromJson(response.data);
    }
    if (deleteNotificationModel.code == 200) {
      print("done");
      // Fluttertoast.showToast(
      //     msg: "حذف",
      //     toastLength: Toast.LENGTH_LONG,
      //     timeInSecForIosWeb: 1,
      //     fontSize: 16.0);

      return true;
    } else {
      print("done");
      print('error delete-product');
      dialog.showErrorDialog(
        btnOnPress: () {},
        context: context,
        msg: "هناك خطا اعد المحاولة",
        ok: "موافق",
      );
    }
  }
}
