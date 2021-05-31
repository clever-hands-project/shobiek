import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shobek/src/Helpers/map_helper.dart';
import 'package:shobek/src/Models/post/shopsModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class ShopsProvider with ChangeNotifier {
  List<Shops> _shops = [];

  List<Shops> get shops {
    return [..._shops];
  }

  NetworkUtil _utils = new NetworkUtil();
  ShopsModel restourant;
  Future<ShopsModel> getShops(
      int id, String search, BuildContext context) async {
    final List<Shops> loaded = [];
    Future.delayed(Duration(microseconds: 150), () {
      restourant = null;
      notifyListeners();
    });

    Map<String, String> headers = {};
    FormData formData = FormData.fromMap({
      "latitude":
          Provider.of<MapHelper>(context, listen: false).position.latitude,
      "longitude":
          Provider.of<MapHelper>(context, listen: false).position.longitude,
      "department_id": id
    });

    Response response =
        await _utils.post("shops", body: formData, headerss: headers);

    if (response.statusCode == 200) {
      print("get shops sucsseful");

      restourant = ShopsModel.fromJson(response.data);
      if (search != null)
        restourant.data.forEach((e) {
          if (e.name.contains(search)) {
            loaded.add(Shops(
                id: e.id,
                name: e.name,
                photo: e.photo,
                department: e.department,
                departmentId: e.departmentId,
                distance: calculateDistance(
                       Provider.of<MapHelper>(context, listen: false)
                                .position
                                .latitude
                            ,
                        Provider.of<MapHelper>(context, listen: false)
                                .position
                                .longitude
                            ,
                        double.parse(e.latitude),
                        double.parse(e.longitude))
                    .round(),
                latitude: e.latitude,
                longitude: e.longitude,
                photos: e.photos,
                active: e.active,
                address: e.address,
                apiToken: e.apiToken,
                city: e.city,
                cityId: e.cityId,
                commissionStatus: e.commissionStatus,
                countryCode: e.countryCode,
                createdAt: e.createdAt,
                details: e.details,
                favorite: e.favorite,
                open: e.open,
                phoneNumber: e.phoneNumber,
                productsNumber: e.productsNumber,
                region: e.region,
                regionId: e.regionId,
                type: e.type,
                viewCount: e.viewCount));
          }
        });
      else
        restourant.data.forEach((e) {
          loaded.add(Shops(
              id: e.id,
              name: e.name,
              photo: e.photo,
              department: e.department,
              departmentId: e.departmentId,
              distance: 
              calculateDistance(
                      Provider.of<MapHelper>(context, listen: false)
                          .position
                          .latitude,
                      Provider.of<MapHelper>(context, listen: false)
                          .position
                          .longitude,
                      double.parse(e.latitude),
                      double.parse(e.longitude))
                  .round(),
              latitude: e.latitude,
              longitude: e.longitude,
              photos: e.photos,
              active: e.active,
              address: e.address,
              apiToken: e.apiToken,
              city: e.city,
              cityId: e.cityId,
              commissionStatus: e.commissionStatus,
              countryCode: e.countryCode,
              createdAt: e.createdAt,
              details: e.details,
              favorite: e.favorite,
              open: e.open,
              phoneNumber: e.phoneNumber,
              productsNumber: e.productsNumber,
              region: e.region,
              regionId: e.regionId,
              type: e.type,
              viewCount: e.viewCount));
        });
      _shops = loaded.toList();
      notifyListeners();
      return ShopsModel.fromJson(response.data);
    } else {
      restourant = ShopsModel.fromJson(response.data);
      _shops = loaded.toList();

      notifyListeners();

      print("error get shops data");
      return ShopsModel.fromJson(response.data);
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
}
