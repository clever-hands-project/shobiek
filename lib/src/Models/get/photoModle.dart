class Photo {
  Photo({
    this.id,
    this.shopId,
    this.photo,
    this.createdAt,
  });

  int id;
  int shopId;
  String photo;
  DateTime createdAt;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        shopId: json["shop_id"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "photo": photo,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}