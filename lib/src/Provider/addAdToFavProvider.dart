import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/post/AddAdToFavorite.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class AddAdToFavProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  AddAdToFavorite addAdToFavModel;
  addAdToFav(String token, int id, BuildContext context) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response =
        await _utils.post("make-shop-favorite/$id", headerss: headers);
    if (response.statusCode == 200) {
      print("get make_ad_favrouit sucsseful");
      addAdToFavModel = AddAdToFavorite.fromJson(response.data);
    } else {
      print("error get make_ad_favrouit data");
      addAdToFavModel = AddAdToFavorite.fromJson(response.data);
    }
    if (addAdToFavModel.code == 200) {
      CustomAlert().toast(
        context: context,
        title: addAdToFavModel.data.value,
      );
    } else {
      print('error get make_ad_favrouit');
      CustomAlert().toast(
        context: context,
        title: addAdToFavModel.error[0].value,
      );
    }
    notifyListeners();
  }
}
