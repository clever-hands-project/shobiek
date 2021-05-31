import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/post/search_model.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class SearchProvider with ChangeNotifier {
  List<Search> _shops = [];

  List<Search> get shops {
    return [..._shops];
  }

  NetworkUtil _util = NetworkUtil();
  SearchModel model;
  CustomDialog _dialog = CustomDialog();

  Future<SearchModel> search(String name, BuildContext context) async {
    final List<Search> loaded = [];
    FormData data = FormData.fromMap({
      'name': name,
    });
    Response response = await _util.post(
      'search-shop-product',
      body: data,
    );
    if (response == null) {
      _dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: "من فضلك تأكد من وجود إتصال بالإنترنت",
      );
      return null;
    }
    if (response.statusCode == 200) {
      model = SearchModel.fromJson(response.data);
      model.data.forEach((e) {
        loaded.add(Search(
            id: e.id,
            name: e.name,
            photo: e.photo,
            department: e.department,
            departmentId: e.departmentId,
            viewCount: e.viewCount,
            distance: calculateDistance(
                    Provider.of<MapHelper>(context, listen: false).position !=
                            null
                        ? Provider.of<MapHelper>(context, listen: false)
                            .position
                            .latitude
                        : 30.7982574,
                    Provider.of<MapHelper>(context, listen: false).position !=
                            null
                        ? Provider.of<MapHelper>(context, listen: false)
                            .position
                            .longitude
                        : 31.0066411,
                    double.parse(e.latitude),
                    double.parse(e.longitude))
                .round(),
            latitude: e.latitude,
            open: e.open,
            productsNumber: e.productsNumber,
            longitude: e.longitude,
            photos: e.photos));
      });
      _shops = loaded.toList();

      notifyListeners();

      return model;
    } else {
      model = SearchModel.fromJson(response.data);
      notifyListeners();

      return model;
    }
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a)) ?? 0;
}
