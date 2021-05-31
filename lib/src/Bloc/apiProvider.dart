import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shobek/src/Models/chat/my_chats_model.dart';
import 'package:shobek/src/Models/chat/ols_messages_model.dart';
import 'package:shobek/src/Models/chat/photo_model.dart';
import 'networkUtlis.dart';

class ApiProvider {
  NetworkUtil _utils = new NetworkUtil();

  Future<dynamic> getMessages(int chatID, String token) async {
    return await _utils
        .get("conversations-messages/$chatID",
            token: token, withToken: true, model: OldMessagesModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> getChats(String token) async {
    return await _utils
        .get("my-conversations/24", withToken: true, model: MyChatsModel())
        .catchError((e) {
      throw e;
    });
  }

  Future<dynamic> uploadPhoto(File photo,String token) async {
    FormData formData =
        FormData.fromMap({"image": await MultipartFile.fromFile(photo.path)});

    return await _utils.post("upload-image",
        withToken: false, body: formData, model: PhotoModel());
  }

  Future<dynamic> getVoiceRing() async {
    return await _utils.get("chat-voice",
        withToken: false, model: PhotoModel());
  }
}
