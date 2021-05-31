import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
import 'package:shobek/src/Models/shop/createProductModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class EditProductProvider with ChangeNotifier {
  String details;
  String placeName;
  String phoneNumber;
  String categoryId;
  String available;
  String price;
  List<File> imgs;
  List<Asset> photos;

  NetworkUtil _utils = new NetworkUtil();
  CustomDialog dialog = CustomDialog();
  CustomProgressDialog customProgressDialog;
  ProgressDialog pr;

  CreateProductModel _model;
  setNull() {
    details = null;
    placeName = null;
    phoneNumber = null;
    categoryId = null;
    available = null;
    price = null;
    imgs = null;
    photos = null;

    notifyListeners();
  }

  createProduct(String token, int id, BuildContext context) async {
    customProgressDialog = CustomProgressDialog(context: context, pr: pr);
    customProgressDialog.showProgressDialog();
    customProgressDialog.showPr();
    List<MultipartFile> _photos = [];
    for (int i = 0; i < photos.length; i++) {
      ByteData byteData = await photos[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(imageData,
          filename: '${photos[i].toString()}.jpg');
      _photos.add(multipartFile);
    }
    print("hi image");

    for (int i = 0; i < imgs.length; i++) {
      print("hi image");
      _photos.add(await MultipartFile.fromFile(imgs[i].path));
    }
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    FormData formData = FormData.fromMap({
      "name": placeName,
      "details": details,
      "category_id": categoryId,
      "available": available,
      "price": price,
      "photos": _photos,
    });

    Response response = await _utils.post("edit-product/$id", 
        body: formData, headerss: headers);

    if (response.statusCode == 200) {
      print("edit-product sucsseful");

      _model = CreateProductModel.fromJson(response.data);
    } else {
      print("error edit-product");
      _model = CreateProductModel.fromJson(response.data);
    }
    if (_model.code == 200) {
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(context: context, title: "تم تعديل منتج بنجاح");
        Navigator.pop(context, true);
      });
      setNull();
      notifyListeners();
    } else {
      print('error edit-service');
      _model = CreateProductModel.fromJson(response.data);
      Future.delayed(Duration(seconds: 1), () {
        customProgressDialog.hidePr();
        CustomAlert().toast(context: context, title: _model.error[0].value);
      });
    }
    notifyListeners();
  }
}
