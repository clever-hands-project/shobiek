import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/Models/get/getFavModel.dart';
import 'package:shobek/src/Models/post/AddAdToFavorite.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class GetMyFavShopProvider with ChangeNotifier {
  List<Fav> _favourite = [];

  List<Fav> get favourite {
    return [..._favourite];
  }

  clear() {
    cartsModel = null;
    notifyListeners();
  }

  AddAdToFavorite deleteAdModel;
  NetworkUtil _utils = new NetworkUtil();
  GetmyFavModel cartsModel;
  deleteFavShop(BuildContext context, int id, String token) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response =
        await _utils.post("remove-shop-favorite/$id", headerss: headers);
    print(_favourite.length);
    if (response.statusCode == 200) {
      notifyListeners();
      deleteAdModel = AddAdToFavorite.fromJson(response.data);
    } else {
      print("error get remove-shop-favorite data");
      deleteAdModel = AddAdToFavorite.fromJson(response.data);
    }
    if (deleteAdModel.code == 200) {
      CustomAlert().toast(
        context: context,
        title: deleteAdModel.data.value,
      );
    } else {
      print('error remove_shop_favrouit');
      CustomAlert().toast(
        context: context,
        title: deleteAdModel.error[0].value,
      );
    }
    notifyListeners();
  }

  Future<GetmyFavModel> getMyFavShop(String token, BuildContext context) async {
    final List<Fav> favouritesAdList = [];

    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Response response =
        await _utils.get("my-favorite-shops", headerss: headers);
    if (response.statusCode == 200) {
      print(" get-Fav shop sucsseful");

      cartsModel = GetmyFavModel.fromJson(response.data);
      cartsModel.data.forEach((e) {
        favouritesAdList.add(Fav(
            id: e.id,
            createdAt: e.createdAt,
            photo: e.photo,
            active: e.active,
            address: e.address,
            cityId: e.cityId,
            apiToken: e.apiToken,
            commissionStatus: e.commissionStatus,
            countryCode: e.countryCode,
            department: e.department,
            departmentId: e.departmentId,
            favorite: e.favorite,
            latitude: e.latitude,
            longitude: e.longitude,
            name: e.name,
            phoneNumber: e.phoneNumber,
            photos: e.photos,
            productsNumber: e.productsNumber,
            region: e.region,
            regionId: e.regionId,
            city: e.city,
            type: e.type,
            viewCount: e.viewCount));
        print('favouriteid=${e.id}');
      });
      _favourite = favouritesAdList.reversed.toList();

      notifyListeners();
      return GetmyFavModel.fromJson(response.data);
    } else {
      print("error  get-Fav shop data");
      cartsModel = GetmyFavModel.fromJson(response.data);

      _favourite = favouritesAdList.reversed.toList();
      notifyListeners();
      return GetmyFavModel.fromJson(response.data);
    }
  }
}
