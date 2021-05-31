import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/get/getCartModel.dart';
import 'package:shobek/src/Models/post/empty_cart_model.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';


class GetCartProvider with ChangeNotifier {
  List<Cart> _carts = [];

  List<Cart> get carts {
    return [..._carts];
  }

  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog;
  EmptyCartModel _emptyModel;
  EmptyCartModel deleteAdModel;
  NetworkUtil _util = NetworkUtil();
  GetCartModel _model;
  ProgressDialog _pr;
  List<Cart> myCartItems;
  Future<void> emptyCart(
    BuildContext context,
  ) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      context: context,
      pr: _pr,
    );

    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.get(
      'delete-all',
    );
    if (response == null) {
      await _customProgressDialog.hidePr();
      await _dialog.showErrorDialog(
          msg: 'يرجى التحقق من الاتصال بالانترنت',
          context: context,
          ok: 'موافق',
          btnOnPress: () {});
      return;
    }
    if (response.statusCode == 200) {
      _emptyModel = EmptyCartModel.fromJson(response.data);
      carts.clear();
      _model = null;
      notifyListeners();
      await _customProgressDialog.hidePr();
      await _dialog.showSuccessDialog(
        btnMsg: 'موافق',
        btnOnPress: () {},
        context: context,
        msg: _emptyModel.data.value,
      );
    } else {
      _emptyModel = EmptyCartModel.fromJson(response.data);
      notifyListeners();
      await _customProgressDialog.hidePr();
      await _dialog.showErrorDialog(
        msg: _model.error[0].value,
        btnOnPress: () {},
        ok: 'موافق',
        context: context,
      );
    }
  }

  clear() {
    _model = null;
    notifyListeners();
  }

  deleteCart(BuildContext context, int id, ) async {

    Response response = await _util.get("delete/$id",);

    final exitingDataIndex = _carts.indexWhere((prod) => prod.id == id);

    _carts.removeAt(exitingDataIndex);
    print(_carts.length);
    if (response.statusCode == 200) {
      notifyListeners();
      deleteAdModel = EmptyCartModel.fromJson(response.data);
    } else {
      //   _carts.insert(exitingDataIndex, exitingData);

      print("error get remove-shop-favorite data");
      deleteAdModel = EmptyCartModel.fromJson(response.data);
    }
    if (deleteAdModel.code == 200) {
      CustomAlert().toast(
        context: context,
        title: deleteAdModel.data.value,
      );
    } else {
      print('error remove_shop_favrouit');
      CustomAlert().toast(
        context: context,
        title: deleteAdModel.error[0].value,
      );
    }
    notifyListeners();
  }

  Future<GetCartModel> getCart(BuildContext context) async {
    final List<Cart> cartsList = [];

    Response response = await _util.get(
      'get-cart',
    );
    if (response.statusCode == 200) {
      _model = GetCartModel.fromJson(response.data);
      _model.data.forEach((e) {
        cartsList.add(Cart(
          createdAt: e.createdAt,
          id: e.id,
          orderId: e.orderId,
          photos: e.photos,
          price: e.price,
          productId: e.productId,
          productName: e.productName,
          quantity: e.quantity,
          shopId: e.shopId,
          shopName: e.shopName,
          state: e.state,
          userId: e.userId,
          userName: e.userName,
        ));
      });
      _carts = cartsList.reversed.toList();
      notifyListeners();
      return _model;
    } else {
      // _cartItemCount = 0;
      _model = GetCartModel.fromJson(response.data);

      _carts = cartsList.reversed.toList();
      notifyListeners();
      return GetCartModel.fromJson(response.data);
    }
  }
}



