import 'dart:convert';

import 'base_model.dart';

MsgModel msgModelFromJson(String str) => MsgModel.fromJson(json.decode(str));

String msgModelToJson(MsgModel data) => json.encode(data.toJson());

class MsgModel extends BaseModel {
  MsgModel({
    this.token,
    this.name,
    this.userId,
    this.secondUserId,
    this.userPhoto,
    this.file,
    this.voice,
    this.latitude,
    this.longitude,
    this.message,
    this.createdAt,
    this.roomID,
  });

  String token;
  String name;
  int userId;
  int secondUserId;
  String userPhoto;
  String file;
  String roomID;
  String voice;
  String latitude;
  String longitude;
  String message;
  String createdAt;

  factory MsgModel.fromJson(Map<String, dynamic> json) => MsgModel(
        roomID: json["room_id"] == null ? null : json["room_id"],
        file: json["file"] == null ? null : json["file"],
        token: json["api_token"] == null ? null : json["api_token"],
        message: json["message"] == null ? null : json["message"],
        name: json["name"] == null ? null : json["name"],
        userId: json["user_id"] == null ? null : json["user_id"],
        secondUserId:
            json["second_user_id"] == null ? null : json["second_user_id"],
        userPhoto: json["user_photo"] == null ? null : json["user_photo"],
        voice: json["voice"] == null ? null : json["voice"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "room_id": roomID = null ? null : roomID,
        "file": file == null ? null : file,
        "api_token": token == null ? null : token,
        "message": message == null ? null : message,
        "name": name == null ? null : name,
        "user_id": userId == null ? null : userId,
        "second_user_id": secondUserId == null ? null : secondUserId,
        "user_photo": userPhoto == null ? null : userPhoto,
        "voice": voice == null ? null : voice,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "created_at": createdAt == null ? null : createdAt,
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return MsgModel.fromJson(json);
  }
}
