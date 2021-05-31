import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/sharedPref_helper.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';
import 'package:shobek/src/MainScreens/driver/driverHomeScreen.dart';
import 'package:shobek/src/MainScreens/shop/ShopMainPage.dart';
import 'package:shobek/src/Models/auth/LoginModel.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  String phone;
  String password;
  int type;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  LoginModel _model;
  SharedPreferences _prefs;
  login(
    String token,
    BuildContext context,
  ) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();

    Map<String, String> headers = {};
    FormData formData = FormData.fromMap({
      "phone_number": phone,
      "password": password,
      "device_token": token,
      "country_code": 20,
    });

    Response response =
        await _utils.post("login", body: formData, headerss: headers);

    if (response.statusCode == 200) {
      print("login sucsseful");
      _model = LoginModel.fromJson(response.data);
    } else {
      print("error login");
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _model = LoginModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
      });
      _prefs = await SharedPreferences.getInstance();
      print('done');
      _prefs.setInt('id', _model.data.id);
      _prefs.setString('name', _model.data.name);
      _prefs.setString('phone', _model.data.phoneNumber);
      _prefs.setString('token', _model.data.apiToken);
      _prefs.setString('address', _model.data.address);
      _prefs.setString('photo', _model.data.photo);
      _prefs.setString('car_form', _model.data.carForm);
      _prefs.setString('license', _model.data.license);
      _prefs.setString('identity', _model.data.identity);
      _prefs.setInt('active', _model.data.active);
      _prefs.setInt('type', _model.data.type);
      _prefs.setInt('cartype', _model.data.carType);
      _prefs.setString('longitude', _model.data.longitude);
      _prefs.setString('latitude', _model.data.latitude);
      _prefs.setInt('cityId', _model.data.cityId);
      _prefs.setString('city', _model.data.city);
      _prefs.setInt('regionId', _model.data.regionId);
      _prefs.setString('region', _model.data.region);
      _prefs.setInt('department_id', _model.data.departmentId);
      _prefs.setString('department', _model.data.department);
      _prefs.setString('driverPrice', _model.data.driverPrice);
      _prefs.setInt('products_number', _model.data.productsNumber);
      _prefs.setInt('commission_status', _model.data.commissionStatus);
      _prefs.setString('workTimeStart', _model.data.openTime);
      _prefs.setString('workTimeEnd', _model.data.closeTime);

      type = _model.data.type;
      notifyListeners();
      await Provider.of<SharedPref>(context, listen: false)
          .getSharedHelper(_prefs);

      if (_model.data.type == 1) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => MainPage()),
            (Route<dynamic> route) => false);
      } else if (_model.data.type == 2) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DriverHomeScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ShopMainPage(),
          ),
          (Route<dynamic> route) => false,
        );
      }

      return _prefs;
    } else {
      print('error login');

      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        dialog.showErrorDialog(
          btnOnPress: () {},
          context: context,
          msg: _model.error[0].value,
          ok: "موافق",
        );
      });
    }
    notifyListeners();
  }
}
