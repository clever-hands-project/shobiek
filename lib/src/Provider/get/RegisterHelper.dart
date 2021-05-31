import 'package:dio/dio.dart';
import 'package:flutter/Material.dart';
import 'package:shobek/src/Models/get/RegionsModel.dart';
import 'package:shobek/src/Models/get/citiesModel.dart';
import 'package:shobek/src/Models/get/departmentsModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class RegisterHelper extends ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  // CustomAlert _alert;
  List<Rogine> rogine;
  List<Department> depart;
  List<Cities> cities;
  getCities(BuildContext context, String id) async {
    CitiesModel _model;
    Response response = await _utils.get("get-cities/$id");
    if (response.statusCode == 200) {
      print("get cities succ");
      _model = CitiesModel.fromJson(response.data);
      cities = _model.data;
      notifyListeners();
    } else {
      cities = [];
      _model = CitiesModel.fromJson(response.data);
    }
  }

  getRogine(BuildContext context) async {
    RogineModel _model;
    Response response = await _utils.get("regions");
    if (response.statusCode == 200) {
      print("get cities succ");
      _model = RogineModel.fromJson(response.data);
      rogine = _model.data;
      notifyListeners();
    }
  }

  getDepartment(BuildContext context) async {
    DepartmentsModel _model;
    Response response = await _utils.get("departments");
    if (response.statusCode == 200) {
      print("get cities succ");
      _model = DepartmentsModel.fromJson(response.data);
      depart = _model.data;
      notifyListeners();
    }
  }
}
