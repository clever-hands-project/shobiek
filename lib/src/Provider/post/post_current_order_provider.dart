import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainScreens/HomeScreen/orders/waitingOrder.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/post/post_orders_model.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PostCurrentOrderProvider with ChangeNotifier {
  ProgressDialog _pr;
  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog;
  PostOrdersModel _model;
  NetworkUtil _util = NetworkUtil();
  String lat;
  String long;
  String orderDrtails;
  String arrivalDetails;
  Future<void> postCart(
    BuildContext context,
  ) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);

    Map<String, dynamic> data = {
      'latitude': lat != null ? lat : 30.7981684,
      'longitude': long != null ? long : 31.0067622,
      "order_time": DateTime.now().toString().substring(0, 19),
      "order_details": orderDrtails,
      "address_details": arrivalDetails,
    };

    FormData formData = FormData.fromMap(data);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'post-cart',
      body: formData,
    );
    // if (response == null) {
    //   await _customProgressDialog.hidePr();
    //   _dialog.showWarningDialog(
    //     btnOnPress: () {},
    //     context: context,
    //     msg: "من فضلك تأكد من وجود إتصال بالإنترنت",
    //   );
    //   return false;
    // }
    if (response.statusCode == 200) {
      _model = PostOrdersModel.fromJson(response.data);
      // cartProvider.carts.clear();
      notifyListeners();
      await _customProgressDialog.hidePr();
      CustomAlert().toast(context: context, title: 'تم اعتماد طلبك');
//      print(_model.data[0].orderId);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => WaitingOrder(),
        ),
      );

      return true;
    } else {
      _model = PostOrdersModel.fromJson(response.data);
      notifyListeners();
      await _customProgressDialog.hidePr();
      await _dialog.showErrorDialog(
        context: context,
        msg: _model.error[0].value,
        ok: 'موافق',
        btnOnPress: () {},
      );
      return false;
    }
  }
}
