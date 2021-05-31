import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../MainWidgets/custom_new_dialog.dart';
import '../Models/shop/deletePhotoModle.dart';
import '../Repository/networkUtlis.dart';

class DeleteShopPhotoProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  DeletePhotoModel deleteNotificationModel;
  CustomDialog dialog = CustomDialog();

  deletNot(String token, int id, BuildContext context) async {
    Response response = await _utils.get(
      "delete-shop-photo/$id",
    );
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
