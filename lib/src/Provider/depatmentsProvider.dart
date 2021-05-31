import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:shobek/src/Models/get/departmentsModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';


class DepartMentProvider with ChangeNotifier {
  List<Departments> _departments = [];

  List<Departments> get departments {
    return [..._departments];
  }

  List<BottomSheetModel> _citiesSheet = [];

  List<BottomSheetModel> get cotiesSheet {
    return [..._citiesSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  DepartmentsModel departMenstModel;
  Future<DepartmentsModel> getDepartements(BuildContext context) async {
    final List<Departments> loaded = [];
    final List<BottomSheetModel> loadedCountriesSheet = [];
    Map<String, String> headers = {};
    Response response =
        await _utils.get("departments", headerss: headers);
    if (response.statusCode == 200) {
      print("get departments sucsseful");

      departMenstModel = DepartmentsModel.fromJson(response.data);
      departMenstModel.data.forEach((e) {
        loadedCountriesSheet.add(BottomSheetModel(
          id: e.id,
          name: e.name,
        ));
      });
      _citiesSheet = loadedCountriesSheet.reversed.toList();
      // loaded.add(Departments(
      //     createdAt: DateTime.now(), id: 0, name: "الكل", photo: ""));
      departMenstModel.data.forEach((e) {
        loaded.add(Departments(
            createdAt: e.createdAt,
            id: e.id,
            name: e.name,
            photo: e.photo,
            selected: false));
      });
      _departments = loaded.reversed.toList();
      notifyListeners();
      return DepartmentsModel.fromJson(response.data);
    } else {
      print("error get departments data");
      return DepartmentsModel.fromJson(response.data);
    }
  }
}

class Departments {
  Departments({
    @required this.id,
    @required this.name,
    @required this.photo,
    @required this.createdAt,
    @required this.selected,
  });

  int id;
  String name;
  String photo;
  DateTime createdAt;
  bool selected;
}
