import 'package:dio/dio.dart';
import 'package:shobek/src/Models/aboutUsModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class AboutUsProvider with ChangeNotifier {
  String content;
  NetworkUtil _utils = new NetworkUtil();
  AboutUsModel aboutUsModel;
  Future<AboutUsModel> getAboutUs() async {
    Map<String, String> headers = {};
    Response response = await _utils.get("about-us", headerss: headers);
    if (response.statusCode == 200) {
      print("get about_us sucsseful");

      aboutUsModel = AboutUsModel.fromJson(response.data);
      content = aboutUsModel.data.content;
      notifyListeners();
      return AboutUsModel.fromJson(response.data);
    } else {
      print("error get about_us data");
      return AboutUsModel.fromJson(response.data);
    }
  }
}
