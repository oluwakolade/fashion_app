class Products {
  final String productName;
  final double productPrice;
  final Category category;

  final String color;
  final String size;
  final String description;
  final String productPhoto;

  Products(
      {required this.productName,
      required this.productPrice,
      required this.description,
      required this.size,
      required this.color,
      required this.productPhoto,
      required this.category});

  Products copyWith({String? productPhoto}) {
    return Products(
        productName: productName,
        productPrice: productPrice,
        description: description,
        size: size,
        color: color,
        productPhoto: productPhoto ?? this.productPhoto,
        category: category);
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'description': description,
      'size': size,
      'color': color,
      'productPhoto': productPhoto,
      'category': category,
    };
  }

  factory Products.fromJson(Map<String, dynamic> json) => Products(
      productName: json['productName'],
      productPrice: json['productPrice'],
      description: json['description'],
      size: json['size'],
      color: json['color'],
      productPhoto: json['productPhoto'],
      category: json['category']);
}

enum Category { hoodies, accessories, shorts, shoes, bags }
