


import 'base_model.dart';

import 'msg_model.dart';


class OldMessagesModel extends BaseModel {
  OldMessagesModel({
    this.code,
    this.data,
  });

  int code;
  List<MsgModel> data;

  factory OldMessagesModel.fromJson(Map<String, dynamic> json) =>
      OldMessagesModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<MsgModel>.from(
                json["data"].map((x) => MsgModel.fromJson(x))),
      );


  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return OldMessagesModel.fromJson(json);
  }
}
