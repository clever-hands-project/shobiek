// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:shobek/src/MainWidgets/custom_new_dialog.dart';
// import 'package:shobek/src/MainWidgets/custom_progress_dialog.dart';
// import 'package:shobek/src/Models/changeData/editAccountModel.dart';
// import 'package:shobek/src/Repository/appLocalization.dart';
// import 'package:shobek/src/Repository/networkUtlis.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditUserDataProvider with ChangeNotifier {
//   String name;
//   List<Asset> photos;
//   File image;
//   String cityId;
//   int carType;
//   String long;
//   String lat;
//   String departMentId;
//   NetworkUtil _utils = new NetworkUtil();
//   CustomDialog dialog = CustomDialog();

//   CustomProgressDialog customProgressDialog;
//   ProgressDialog pr;
//   EditAccountModel _model;
//   SharedPreferences _prefs;
//   changeUserData(String token, BuildContext context) async {
//     customProgressDialog = CustomProgressDialog(context: context, pr: pr);
//     customProgressDialog.showProgressDialog();
//     customProgressDialog.showPr();
//     Map<String, String> headers = {"Authorization": "Bearer $token"};
//     FormData formData = FormData.fromMap({
//       "name": name,
//       "photo": image == null ? null : await MultipartFile.fromFile(image.path),
//       "city_id": cityId,
//       "car_type": carType,
//       "department_id": departMentId,
//       "longitude": long != null ? long : 31.0066411,
//       "latitude": lat != null ? lat : 30.7982574,
//       "photos[]": photos,
//     });

//     Response response =
//         await _utils.post("profile-edit", body: formData, headerss: headers);
//     if (response == null) {
//       print('error change_password');
//       Future.delayed(Duration(seconds: 1), () {
//         customProgressDialog.hidePr();
//         dialog.showWarningDialog(
//           btnOnPress: () {},
//           context: context,
//           msg: localization.text("internet"),
//         );
//       });

//       return;
//     }
//     if (response.statusCode == 200) {
//       print("edit_account data sucsseful");
//       _model = EditAccountModel.fromJson(response.data);
//     } else {
//       print("error  edit_account data");

//       _model = EditAccountModel.fromJson(response.data);
//     }
//     if (_model.code == 200) {
//       _prefs = await SharedPreferences.getInstance();
//       _prefs.setString("name", _model.data.name);
//       _prefs.setString("photo", _model.data.photo);
//       _prefs.setString("email", _model.data.email);
//       Future.delayed(Duration(seconds: 1), () {
//         customProgressDialog.hidePr();
//         Fluttertoast.showToast(
//             msg: localization.text("edit_success"),
//             toastLength: Toast.LENGTH_LONG,
//             timeInSecForIosWeb: 1,
//             fontSize: 16.0);
//         // Navigator.pushAndRemoveUntil(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => MainPage(
//         //       index: 1,
//         //       key: GlobalKey(),
//         //     ),
//         //   ),
//         //   (Route<dynamic> route) => false,
//         // );
//       });
//       return true;
//     } else {
//       print("error  edit_account data");
//       Future.delayed(Duration(seconds: 1), () {
//         customProgressDialog.hidePr();
//         dialog.showErrorDialog(
//           btnOnPress: () {},
//           context: context,
//           msg: _model.error[0].value,
//           ok: localization.text("ok"),
//         );
//       });
//     }
//     notifyListeners();
//   }
// }
