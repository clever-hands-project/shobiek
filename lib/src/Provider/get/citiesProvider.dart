import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Bloc/networkUtlis.dart';
import 'package:shobek/src/MainWidgets/labeled_bottom_sheet.dart';
import 'package:shobek/src/Models/get/citiesModel.dart';

class CitiesProvider with ChangeNotifier {
  // String id = "4";
  List<Cities> _cities = [];

  List<Cities> get coties {
    return [..._cities];
  }

  List<BottomSheetModel> _citiesSheet = [];

  List<BottomSheetModel> get cotiesSheet {
    return [..._citiesSheet];
  }

  NetworkUtil _utils = new NetworkUtil();
  CitiesModel categoriesModel;
  Future<CitiesModel> getCities(String id, BuildContext context) async {
    categoriesModel = null;
    final List<Cities> loadedCountries = [];
    final List<BottomSheetModel> loadedCountriesSheet = [];

    Response response = await _utils.get("get-cities/$id");
    if (response.statusCode == 200) {
      print("get get-cities sucsseful");

      categoriesModel = CitiesModel.fromJson(response.data);

      categoriesModel.data.forEach((e) {
        loadedCountriesSheet.add(BottomSheetModel(
            id: e.id, name: e.name, realID: e.regionId.toString()));
      });
      _citiesSheet = loadedCountriesSheet.reversed.toList();
      categoriesModel.data.forEach((e) {
        loadedCountries.add(Cities(
            country: e.region,
            countryId: e.regionId,
            createdAt: e.createdAt,
            id: e.id,
            name: e.name,
            selected: false));
      });

      _cities = loadedCountries.reversed.toList();
      notifyListeners();
      return CitiesModel.fromJson(response.data);
    } else {
      print("error get get-cities data");

      categoriesModel = CitiesModel.fromJson(response.data);
      _citiesSheet = loadedCountriesSheet.reversed.toList();
      _citiesSheet = loadedCountriesSheet.reversed.toList();
      notifyListeners();

      print("error get get-cities data");
      return CitiesModel.fromJson(response.data);
    }
  }
}

class Cities {
  Cities(
      {@required this.id,
      @required this.name,
      @required this.countryId,
      @required this.country,
      @required this.createdAt,
      @required this.selected});

  int id;
  String name;
  int countryId;
  String country;
  bool selected;
  DateTime createdAt;
}
