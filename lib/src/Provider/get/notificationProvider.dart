import 'package:dio/dio.dart';
import 'package:shobek/src/Models/get/notification.dart';
import 'package:shobek/src/Repository/appLocalization.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:flutter/material.dart';

class NotoficationProvider with ChangeNotifier {
  List<Notifications> _notifications = [];

  List<Notifications> get notfications {
    return [..._notifications];
  }

  NetworkUtil _utils = new NetworkUtil();
  NotificationModel notificationModel;
  bool error = false;
  void removeItem(int productId) {
    _notifications.removeAt(productId);
    print(_notifications.length);
    notifyListeners();
  }

  Future<NotificationModel> getNotification(String token) async {
    final List<Notifications> loadedNotifications = [];
    Map<String, String> headers = {
      "X-localization": localization.currentLanguage.toString(),
      "Authorization": "Bearer $token"
    };
    Response response =
        await _utils.get("list-notifications", headerss: headers);
    if (response.statusCode == 200) {
      print("get notification data sucsseful");
      notificationModel = NotificationModel.fromJson(response.data);
      notificationModel.data.forEach((element) {
        loadedNotifications.add(Notifications(
            id: element.id,
            message: element.message,
            title: element.title,
            createdAt: element.createdAt,
            type: element.type,
            orderId: element.offerId,
            offerId: element.offerId,
            paymentId: element.paymentId
            ));
      });

      _notifications = loadedNotifications.reversed.toList();
      error = false;

      notifyListeners();
      return NotificationModel.fromJson(response.data);
    } else {
      print("error get notification data");
      notificationModel = NotificationModel.fromJson(response.data);
      notifyListeners();
      return NotificationModel.fromJson(response.data);
    }
  }
}
