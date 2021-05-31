import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:shobek/src/Models/shop/servicesCatogoryModle.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ProductCategoryProvider with ChangeNotifier {
  List<ServicesCatogor> _services = [];

  List<ServicesCatogor> get services {
    return [..._services];
  }

  List<BottomSheetModel> _bottomSheet = [];

  List<BottomSheetModel> get bottomSheet {
    return [..._bottomSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  ServicesCatogoryModel regionModel;
  Future<ServicesCatogoryModel> getServicesCatogory(BuildContext context) async {
    final List<ServicesCatogor> loaded = [];
    final List<BottomSheetModel> loadedSheetModel = [];

    Map<String, String> headers = {};
    Response response = await _utils.get("categories", headerss: headers);
    if (response.statusCode == 200) {
      print("get -categories sucsseful");

      regionModel = ServicesCatogoryModel.fromJson(response.data);
      regionModel.data.forEach((e) {
        loadedSheetModel.add(
            BottomSheetModel(id: e.id, name: e.name, realID: e.id.toString()));
      });
      _bottomSheet = loadedSheetModel.reversed.toList();

      regionModel.data.forEach((e) {
        loaded.add(ServicesCatogor(
          createdAt: e.createdAt,
          id: e.id,
          name: e.name,
        ));
      });
      _services = loaded.reversed.toList();
      notifyListeners();
      return ServicesCatogoryModel.fromJson(response.data);
    } else {
      print("error get -categories data");
      return ServicesCatogoryModel.fromJson(response.data);
    }
  }
}
