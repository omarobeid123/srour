class ProductModel {
  final String name;
  final String description;
  final String price;
  final String image;
  final String color;
  int count;

  ProductModel(
      {required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.color,
      this.count = 1});

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        "description": description,
        "image": image,
        "count": count,
        "color": color
      };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      price: json['price'],
      description: json["description"],
      image: json["image"],
      count: json["count"],
      color: json["color"],
    );
  }
}
