import 'package:flutter/material.dart';
import 'package:shobek/src/Models/get/productsFilterModle.dart';
import 'package:shobek/src/Models/post/shopsModel.dart';
import 'package:shobek/src/Models/post/search_model.dart';

class CheckProvider with ChangeNotifier {
  List<ProductFilter> productsFilter = [];
  List<Shops> shopsFilter = [];
  List<Search> searchResults;
  String errorMessage;
  SearchModel model;
  bool isLoading = false;
  TextEditingController controller = new TextEditingController();
  void assignValueProduct({List<ProductFilter> products}) {
    productsFilter = products;

    notifyListeners();
  }

  void assignValueShops({List<Shops> shops}) {
    shopsFilter = shops;

    notifyListeners();
  }

  void searchResult(
      {List<Search> searchResultsparmter,
      TextEditingController controllerPamter,
      String errorMessagePramter,
      bool isLoadingParmter}) {
    searchResults = searchResultsparmter;
    controller = controllerPamter;
    errorMessage = errorMessagePramter;
    isLoading = isLoadingParmter;
    notifyListeners();
  }
}
