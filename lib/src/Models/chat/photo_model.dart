
import 'base_model.dart';



class PhotoModel extends BaseModel {
  PhotoModel({
    this.code,
    this.data,
  });

  int code;
  String data;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data,
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) {
    return PhotoModel.fromJson(json);
  }
}


