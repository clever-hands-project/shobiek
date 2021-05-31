import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shobek/src/Models/post/acceptOfferModel.dart';
import 'package:shobek/src/Repository/networkUtlis.dart';
import 'package:shobek/src/MainScreens/Chat/chat_room.dart';

class AcceptOfferProvider with ChangeNotifier {
  NetworkUtil _utils = new NetworkUtil();
  AcceptOfferModel acceptOfferModel;
  Future<AcceptOfferModel> acceptOffer(int id, BuildContext context) async {
    Response response = await _utils.post(
      "accept-offer/$id",
    );
    if (response.statusCode == 200) {
      print("get accept-offer sucsseful");

      acceptOfferModel = AcceptOfferModel.fromJson(response.data);
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ChatRoom(
            chateId: acceptOfferModel.data.id,
            userName: acceptOfferModel.data.driver,
            orderPrice: acceptOfferModel.data.orderPrice,
            price: acceptOfferModel.data.price,
            phone: acceptOfferModel.data.driverPhone,
          ),
        ),
      );
      notifyListeners();
      return AcceptOfferModel.fromJson(response.data);
    } else {
      print("error post accept-offer data");
      return AcceptOfferModel.fromJson(response.data);
    }
  }
}
