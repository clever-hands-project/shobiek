import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/shop/productsShopModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ProductsShopProvider extends ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  List<ProductsShop> productsList;
  ShopProductsModle _model;
  CustomAlert dialog = CustomAlert();
  // CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  getProducts(BuildContext context) async {
    productsList = null;
    Map<String, String> headers = {
      "X-localization": "ar",
      "Authorization": "Bearer 9uYxdcGamCX",
    };
    Response response = await _util.get("my-products", headerss: headers);
    if (response.statusCode == 200) {
      print("get ProductsSucss");
      _model = ShopProductsModle.fromJson(response.data);
      if (_model.data != null) {
        productsList = _model.data;
        notifyListeners();
      } else {
        print("no products");
        productsList = [];
        // Future.delayed(Duration(seconds: 1), () {
        //   customProgressDialog.hidePr();
        // });
        notifyListeners();
      }
    }
  }
}
