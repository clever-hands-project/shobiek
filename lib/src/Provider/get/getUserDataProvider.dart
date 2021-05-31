import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Models/auth/AuthModle.dart';
import 'package:shobek/src/Provider/auth/AuthController.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class GetUserDataProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  AuthModel userModel;
  Future<AuthModel> getUserData(BuildContext context) async {
    Response response = await _utils.get("user-data");
    if (response.statusCode == 200) {
      print("get user-data sucsseful");
      userModel = AuthModel.fromJson(response.data);
      Provider.of<AuthController>(context, listen: false)
          .storageUserData(json.encode(response.data));
      Provider.of<AuthController>(context, listen: false).type =
          userModel.data.type;
      print('done');

      notifyListeners();
      return AuthModel.fromJson(response.data);
    } else {
      print("error get user-data data");
      return null;
    }
  }
}
