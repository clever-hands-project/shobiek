import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/auth/AuthModle.dart';
import 'package:shobek/src/Models/auth/editPassModel.dart';
import 'package:shobek/src/Models/auth/phoneVerificationModel.dart';
import 'package:shobek/src/Models/auth/register_mobileModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class AuthController extends ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;
  RegisterMobileModel _registerMobileModel;
  PhoneVerificationModel _phoneVerificationModel;
  AuthModel userModel;
  SharedPreferences _prefs;
  CustomAlert _alert = CustomAlert();
  int type;
  String name;
  String details;

  List<File> imgs;
  List<Asset> photos;
  File photo;
  String cityId;
  int carType;
  String long;
  String lat;
  String departMent;
  String departMentId;
  String phone;
  Map<String, String> headers = {"X-localization": "ar"};
  FirebaseMessaging _fcm = FirebaseMessaging();

  Future<bool> registerMobile(BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();

    FormData _formData = FormData.fromMap({
      "phone_number": phone,
      "country_code": "02",
    });
    Response response = await _utils.post("register-mobile",
        headerss: headers, body: _formData);

    if (response.statusCode == 200) {
      print("sucss");
      _registerMobileModel = RegisterMobileModel.fromJson(response.data);

      print("sendCode Sucss");
      customProgressDialog.hidePr();
      _alert.toast(context: context, title: _registerMobileModel.data);

      notifyListeners();
      return true;
    } else {
      print("sendCode error");
      _registerMobileModel = RegisterMobileModel.fromJson(response.data);
      customProgressDialog.hidePr();
      _alert.toast(
          context: context, title: _registerMobileModel.error.first.value);
      notifyListeners();
      return false;
    }
  }

  Future<bool> phoneVerification(BuildContext context, String code) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();

    FormData _formData = FormData.fromMap({
      "phone_number": phone,
      "country_code": "02",
      "code": code,
    });
    Response response = await _utils.post("phone-verification",
        headerss: headers, body: _formData);

    if (response.statusCode == 200) {
      print("sucss");
      _phoneVerificationModel = PhoneVerificationModel.fromJson(response.data);

      print("get Sucss");
      customProgressDialog.hidePr();
      _alert.toast(context: context, title: _phoneVerificationModel.data.value);
      notifyListeners();
      return true;
    } else {
      print("sendCode error");
      _phoneVerificationModel = PhoneVerificationModel.fromJson(response.data);
      customProgressDialog.hidePr();
      _alert.toast(
          context: context, title: _phoneVerificationModel.error.first.value);
      notifyListeners();
      return false;
    }
  }

  Future<bool> resendCode(BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();

    FormData _formData = FormData.fromMap({
      "phone_number": phone,
      "country_code": "02",
    });
    Response response =
        await _utils.post("resend-code", headerss: headers, body: _formData);

    if (response.statusCode == 200) {
      print("sucss");
      _registerMobileModel = RegisterMobileModel.fromJson(response.data);

      print("sendCode Sucss");
      customProgressDialog.hidePr();
      _alert.toast(context: context, title: _registerMobileModel.data);
      notifyListeners();
      return true;
    } else {
      print("sendCode error");
      _registerMobileModel = RegisterMobileModel.fromJson(response.data);
      customProgressDialog.hidePr();
      _alert.toast(
          context: context, title: _registerMobileModel.error.first.value);
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(
    BuildContext context, {
    String name,
    String password,
    // String deviceToken,
    String countryCode,
    File photo,
    String cityId,
    File identity,
    File license,
    File carForm,
    String carType,
    String departmentId,
    String address,
    String passwordConfirm,
    String details,
  }) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    _prefs = await SharedPreferences.getInstance();
    String deviceToken = await _fcm.getToken();
    print("deviceToken : $deviceToken");
    FormData _formData = FormData.fromMap({
      "type": type,
      "phone_number": phone,
      "name": name,
      "longitude":
          Provider.of<MapHelper>(context, listen: false).position.latitude,
      "latitude":
          Provider.of<MapHelper>(context, listen: false).position.longitude,
      "photo": photo == null ? null : await MultipartFile.fromFile(photo.path),
      "password": password,
      "password_confirmation": passwordConfirm,
      "device_token": deviceToken,
      "city_id": cityId,
      "identity":
          identity == null ? null : await MultipartFile.fromFile(identity.path),
      "license":
          license == null ? null : await MultipartFile.fromFile(license.path),
      "car_form":
          carForm == null ? null : await MultipartFile.fromFile(carForm.path),
      "country_code": "20",
      "car_type": carType,
      "department_id": departmentId,
      "address": address,
      "details": details,
    });

    Response response =
        await _utils.post("register", headerss: headers, body: _formData);

    if (response.statusCode == 200) {
      print("register succ");
      userModel = AuthModel.fromJson(response.data);
      type = userModel.data.type;
      userModel.data.active = 0;
      NetworkUtil.token = userModel.data.apiToken;
      storageUserData(json.encode(response.data));
      customProgressDialog.hidePr();
      notifyListeners();
      return true;
    } else {
      print("error");
      userModel = AuthModel.fromJson(response.data);
      _alert.toast(context: context, title: userModel.error.first.value);
      customProgressDialog.hidePr();
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(BuildContext context, {String password}) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    String deviceToken = await _fcm.getToken();
    print(deviceToken);
    FormData _formData = FormData.fromMap({
      "phone_number": phone,
      "country_code": "20",
      "device_token": deviceToken,
      "password": password,
    });
    Response response = await _utils.post("login", body: _formData);
    if (response.statusCode == 200) {
      print("register succ");
      userModel = AuthModel.fromJson(response.data);
      NetworkUtil.token = userModel.data.apiToken;
      type = userModel.data.type;
      storageUserData(json.encode(response.data));
      customProgressDialog.hidePr();
      notifyListeners();
      return true;
    } else {
      print("error");
      userModel = AuthModel.fromJson(response.data);
      _alert.toast(context: context, title: userModel.error.first.value);
      customProgressDialog.hidePr();
      notifyListeners();
      return false;
    }
  }

  storageUserData(String data) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString("userData", data);
  }

  Future<bool> getStorgeData() async {
    _prefs = await SharedPreferences.getInstance();
    String data = _prefs.getString("userData");
    print(data);
    if (data != null) {
      userModel = AuthModel.fromJson(json.decode(data));
      NetworkUtil.token = userModel.data.apiToken;
      type = userModel.data.type;
      name = userModel.data.name;
      lat = userModel.data.latitude;
      long = userModel.data.longitude;
      departMent = userModel.data.department;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  editUserData(
    BuildContext context,
  ) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    AuthModel edit;
    List<MultipartFile> _photos = [];
    if (photos != null && photos.length > 0) {
      for (int i = 0; i < photos.length; i++) {
        ByteData byteData = await photos[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        MultipartFile multipartFile = MultipartFile.fromBytes(imageData,
            filename: '${photos[i].toString()}.jpg');
        _photos.add(multipartFile);
      }
    }
    print("hi image");

    // for (int i = 0; i < imgs.length; i++) {
    //   print("hi image");
    //   _photos.add(await MultipartFile.fromFile(imgs[i].path));
    // }
    FormData _formData = FormData.fromMap({
      "name": name,
      "photo": photo == null ? null : await MultipartFile.fromFile(photo.path),
      "city_id": cityId,
      "car_type": carType,
      "department_id": departMentId,
      "photos": _photos,
      "longitude": long,
      "latitude": lat,
      "details": details,
    });

    Response response = await _utils.post("profile-edit", body: _formData);

    if (response.statusCode == 200) {
      print("edit succ");
      edit = AuthModel.fromJson(response.data);
      userModel.data.name = edit.data.name;
      userModel.data.photo = edit.data.photo;
      userModel.data.cityId = edit.data.cityId;
      userModel.data.carType = edit.data.carType;
      userModel.data.departmentId = edit.data.departmentId;
      userModel.data.photos = edit.data.photos;
      userModel.data.details = edit.data.details;
      storageUserData(json.encode(userModel.toJson()));
      customProgressDialog.hidePr();
      notifyListeners();
      return true;
    } else {
      print("error");
      userModel = AuthModel.fromJson(response.data);
      _alert.toast(context: context, title: userModel.error.first.value);
      customProgressDialog.hidePr();
      notifyListeners();
      return false;
    }
  }

  editPassword(BuildContext context,
      {String oldPass, String newPass, String regPass}) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    EditPasswordModel _model;
    FormData _formData = FormData.fromMap({
      "current_password": oldPass,
      "new_password": newPass,
      "password_confirmation": regPass,
    });

    Response response = await _utils.post("change-password", body: _formData);

    if (response.statusCode == 200) {
      print("Edit sucss");
      _model = EditPasswordModel.fromJson(response.data);
      customProgressDialog.hidePr();
      _alert.toast(context: context, title: _model.data.value);
      notifyListeners();
    } else {
      _model = EditPasswordModel.fromJson(response.data);
      customProgressDialog.hidePr();
      _alert.toast(context: context, title: _model.error.first.value);
      notifyListeners();
    }
  }

  editCarData(
      BuildContext context, File identity, File license, File carForm) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    FormData _formData = FormData.fromMap({
      "car_form":
          carForm == null ? null : await MultipartFile.fromFile(carForm.path),
      "identity":
          identity == null ? null : await MultipartFile.fromFile(identity.path),
      "license":
          license == null ? null : await MultipartFile.fromFile(license.path),
    });
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    Response response = await _utils.post("edit-car-data", body: _formData);
    if (response.statusCode == 200) {}
  }
}
