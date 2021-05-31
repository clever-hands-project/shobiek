import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/post/addToCartModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

enum CartOptions {
  Add,
  Edit,
}

class AddToCartProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  CustomDialog _dialog = CustomDialog();
  AddToCartModel _model;

  Future<void> addToCart(
      BuildContext context, int productId, int quantity) async {
    Map<String, dynamic> map = {
      'product_id': productId,
      'quantity': quantity,
    };

    FormData data = FormData.fromMap(map);

    Response response = await _util.post(
      'add-to-cart',
      body: data,
    );

    if (response.statusCode == 200) {
      _model = AddToCartModel.fromJson(response.data);
      notifyListeners();

      CustomAlert().toast(context: context, title: 'تم اعتماد طلبك');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => MainPage(
            index: 1,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      _model = AddToCartModel.fromJson(response.data);
      notifyListeners();

      await _dialog.showErrorDialog(
        context: context,
        msg: _model.error[0].value,
        ok: 'موافق',
        btnOnPress: () {},
      );
    }
  }
}
