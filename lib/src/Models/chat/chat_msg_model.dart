import 'msg_model.dart';

class ChatMsgModel {
  String channel;
  MsgModel data;

  ChatMsgModel({
    this.channel,
    this.data,
  });

  factory ChatMsgModel.fromJson(Map<String, dynamic> json) => ChatMsgModel(
        channel: json["channel"],
        data: MsgModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "channel": channel,
        "data": data.toJson(),
      };
}
