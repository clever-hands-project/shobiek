import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shobek/src/MainWidgets/custom_alert.dart';
import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
import 'package:shobek/src/Models/DriverModel/avilabiltyModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:shobek/src/MainWidgets/request_location_screen.dart';
import '../../Helpers/map_helper.dart';
import '../auth/AuthController.dart';

class AvilableTimerProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  AvailabilityModle avalableModel;
  CustomDialog dialog = CustomDialog();
  var isEnabled;
  SharedPreferences _prefs;
  changeAvailable({int available, BuildContext context}) async {
    if (available == 1) {
      isEnabled = await getUserLocation(context);
    } else {
      isEnabled = false;
      Provider.of<AuthController>(context, listen: false)
          .userModel
          .data
          .available = false;
    }
    if (isEnabled) {
      FormData formData = FormData.fromMap({
        "availability": available,
        "latitude":
            Provider.of<MapHelper>(context, listen: false).position.latitude,
        "longitude":
            Provider.of<MapHelper>(context, listen: false).position.longitude,
      });

      Response response = await _utils.post(
        "availability",
        body: formData,
      );

      if (response.statusCode == 200) {
        print("get availability sucsseful");
        avalableModel = AvailabilityModle.fromJson(response.data);
      } else {
        print("error get availability data");
        avalableModel = AvailabilityModle.fromJson(response.data);
      }
      if (avalableModel.code == 200) {
        if (avalableModel.data.availability == "1") {
          // CustomAlert()
          //     .toast(context: context, title: "تم تغير الحالة الي متاح بنجاح");
        } else
          CustomAlert().toast(
              context: context, title: "تم تغير الحالة الي غير متاح بنجاح");
        _prefs = await SharedPreferences.getInstance();
        _prefs.setString('avalable', avalableModel.data.availability);
        return avalableModel.data.availability;
      } else {
        print('error confirmed');
        CustomAlert().toast(
          context: context,
          title: avalableModel.error[0].value,
        );
      }
    } else {
      FormData formData = FormData.fromMap({
        "availability": 0,
        "latitude":
            Provider.of<MapHelper>(context, listen: false).position.latitude,
        "longitude":
            Provider.of<MapHelper>(context, listen: false).position.longitude,
      });
      Provider.of<AuthController>(context, listen: false)
          .userModel
          .data
          .available = false;
      Response response = await _utils.post(
        "availability",
        body: formData,
      );

      if (response.statusCode == 200) {
        print("get availability sucsseful");
        avalableModel = AvailabilityModle.fromJson(response.data);
      } else {
        print("error get availability data");
        avalableModel = AvailabilityModle.fromJson(response.data);
      }
      if (avalableModel.code == 200) {
        if (avalableModel.data.availability == "1") {
          CustomAlert()
              .toast(context: context, title: "تم تغير الحالة الي متاح بنجاح");
        } else
          CustomAlert().toast(
              context: context, title: "تم تغير الحالة الي غير متاح بنجاح");
        _prefs = await SharedPreferences.getInstance();
        _prefs.setString('avalable', avalableModel.data.availability);
        return avalableModel.data.availability;
      } else {
        print('error confirmed');
        CustomAlert().toast(
          context: context,
          title: avalableModel.error[0].value,
        );
      }
    }
  }
}

Future<bool> getUserLocation(BuildContext context) async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    print('nit ');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (c) => RequestLocationScreen()),
      (route) => false,
    );

    return false;
  }
  print('ss');

  LocationPermission permission = await Geolocator.checkPermission();
  print('ss');

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
    return false;
  }
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
  }
  return true;
}
