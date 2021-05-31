import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref with ChangeNotifier {
  String token;
  int id;
  String photo;
  String phone;
  int type;
  String name;
  String email;
  int countryCode;
  String address;
  int active;
  double lat;
  double long;
  String avalable;
  int cityId;
  String city;
  int regionId;
  String region;
  int departmentId;
  String department;
  int productsNumber;
  int commissionStatus;
  var idNumber;
  String job;
  String barithDay;
  String workTimeStart;
  String workTimeEnd;
  String identity;
  String license;
  String carForm;
  String driverPrice;
  int carType;

  getSharedHelper(SharedPreferences pref) {
    print("start shared");
    id = pref.get('id');
    name = pref.get('name');
    phone = pref.get('phone');
    token = pref.get('token');
    carType = pref.get('cartype');
    countryCode = pref.get('countrycode');
    address = pref.get('address');
    photo = pref.get('photo');
    avalable = pref.get('avalable') ?? "0";
    identity = pref.get('identity');
    license = pref.get('license');
    carForm = pref.get('car_form');
    driverPrice = pref.get('driverPrice');
    active = pref.get('active');
    type = pref.get('type');
    long = pref.get('long');
    lat = pref.get('lat');
    cityId = pref.get('cityId');
    city = pref.get('city');
    regionId = pref.get('regionId');
    region = pref.get('region');
    departmentId = pref.get('department_id');
    department = pref.get('department');
    productsNumber = pref.get('products_number');
    commissionStatus = pref.get('commission_status');
    workTimeStart = pref.get('workTimeStart') ??
        DateFormat('jm').format(DateTime.now()).toString();
    workTimeEnd = pref.get('workTimeEnd') ??
        DateFormat('jm').format(DateTime.now()).toString();
    print(token);
    print(phone);
    print(name);
    print(photo);
    print(lat);
    print(long);
    print(avalable);
    print(cityId);
    print(city);
    print(workTimeStart);
    print(workTimeEnd);

    print("i get shared");
    notifyListeners();
    return pref;
  }
}
