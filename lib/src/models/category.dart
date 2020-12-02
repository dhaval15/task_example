class Category {
  String id;
  String name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(dynamic json) => Category(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
