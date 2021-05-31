import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shobek/src/MainScreens/mainPage.dart';
import 'package:shobek/src/Models/post/clientCancelOrderModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';

class CancelOrderProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  ClientCancelOrder addAdToFavModel;
  clientCancelOder(
 int id, String reason, BuildContext context) async {
    FormData formData = FormData.fromMap({"cancel_reason_client": reason});

    Response response =
        await _utils.post("client-cancel-order/$id", body: formData);
    if (response.statusCode == 200) {
      print("get make_ad_favrouit sucsseful");
      addAdToFavModel = ClientCancelOrder.fromJson(response.data);
    } else {
      print("error get make_ad_favrouit data");
      addAdToFavModel = ClientCancelOrder.fromJson(response.data);
    }
    if (addAdToFavModel.code == 200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              elevation: 3,
              contentPadding: EdgeInsets.all(5),
              children: <Widget>[
                Text(
                  addAdToFavModel.data[0].value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 3,
                    height: 45,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "موافق",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          });
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(pageBuilder: (_, __, ___) => MainPage()),
        (route) => false,
      );

      Fluttertoast.showToast(msg: 'تم إلغاء الطلب, يرجى الإعادة مرة أخرى');
    } else {
      print('error get make_ad_favrouit');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              elevation: 3,
              contentPadding: EdgeInsets.all(5),
              children: <Widget>[
                Text(
                  addAdToFavModel.error[0].value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 3,
                    height: 45,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "موافق",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          });
    }

    notifyListeners();
  }
}
