import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/get/SliderModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class SliderProvider with ChangeNotifier {
  List<SliderItems> _sliders = [];

  List<SliderItems> get sliders {
    return [..._sliders];
  }

  NetworkUtil _utils = new NetworkUtil();
  SliderModel notificationModel;
  bool error = false;
  void removeItem(int productId) {
    _sliders.removeAt(productId);
    print(_sliders.length);
    notifyListeners();
  }

  Future<SliderModel> getSlider() async {
    final List<SliderItems> loadedNotifications = [];
    Map<String, String> headers = {};
    Response response =
        await _utils.get("splashes", headerss: headers);
    if (response.statusCode == 200) {
      print("get splashes data sucsseful");
      notificationModel = SliderModel.fromJson(response.data);
      notificationModel.data.forEach((element) {
        loadedNotifications.add(SliderItems(
          id: element.id,
          photo: element.photo,
          provider: element.provider,
          providerId: element.providerId,
          url: element.url,
          createdAt: element.createdAt,
        ));
      });
      _sliders = loadedNotifications.reversed.toList();
      error = false;
      notifyListeners();
      return SliderModel.fromJson(response.data);
    } else {
      print("error get splashes data");
      return SliderModel.fromJson(response.data);
    }
  }
}
