import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/compines.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ComplaintProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  Complaint model;
  String title;
  String content;
  complaint(int orderId, BuildContext context) async {
    FormData formData = FormData.fromMap({"title": title, "details": content});

    Map<String, String> headers = {};
    Response response = await _utils.post("complaint/$orderId",
        headerss: headers, body: formData);
    if (response.statusCode == 200) {
      print("get complaint sucsseful");
      model = Complaint.fromJson(response.data);
    } else {
      print("error get complaint data");
      model = Complaint.fromJson(response.data);
    }
    if (response.statusCode == 200) {
      model = Complaint.fromJson(response.data);
      CustomAlert()
          .toast(context: context, title: " تم ارسال الشكوي بنجاح");
      Navigator.pop(context);
    } else {
      CustomAlert()
          .toast(context: context, title: " حدث خطا يرجى اعادة المحاولة");
    }
    notifyListeners();
  }
}
