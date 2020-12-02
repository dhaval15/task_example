class Item {
  String id;
  String categotyId;
  int count;

  Item({
    this.id,
    this.count,
    this.categotyId,
  });

  factory Item.fromJson(dynamic json) => Item(
        id: json['id'],
        categotyId: json['c_id'],
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'c_id': categotyId,
        'count': count,
      };
}
