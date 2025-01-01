import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String id;
  final String categoryId;
  final String name;
  final double price;
  final String description;
  final double ratings;
  final int review;
  final String image;
  final String feature;
  final List<String>? images;
  final bool isFavorite;
  // final List<UserReviews> userReviews;

  Products(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.description,
      required this.ratings,
      required this.review,
      required this.categoryId,
      required this.feature,
      this.images,
      this.isFavorite = false});

  Products copyWith({String? image}) {
    return Products(
        id: id,
        name: name,
        price: price,
        image: image ?? this.image,
        description: description,
        ratings: ratings,
        review: review,
        categoryId: categoryId,
        feature: feature,
        isFavorite: isFavorite);
  }

  static Products empty() => Products(
      id: "",
      name: "",
      price: 0,
      image: "",
      description: "",
      ratings: 0,
      review: 0,
      categoryId: '',
      images: [],
      feature: '',
      isFavorite: false);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'price': price,
      'description': description,
      'ratings': ratings,
      'review': review,
      'image': image,
      'images': images,
      'isFavorite': isFavorite,
      "feature": feature,
    };
  }

  factory Products.fromJson(Map<String, dynamic> json, {String? documentId}) {
    return Products(
        id: documentId ?? json['id'] ?? '',
        name: json['name'],
        price: double.parse((json['price'] ?? 0.0).toString()),
        description: json['description'] ?? '',
        ratings: json['ratings'],
        review: json['review'],
        image: json['image'] ?? '',
        images: json['images'] != null ? List<String>.from(json['images']) : [],
        categoryId: json['categoryId'] ?? '',
        isFavorite: json['isFavorite'] ?? false,
        feature: json['feature'] ?? '');
  }

  factory Products.fromFirestore(QueryDocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Products(
        id: data['id'],
        name: data['name'],
        price: double.parse((data['price'] ?? 0.0).toString()),
        description: data['description'] ?? '',
        ratings: data['ratings'],
        review: data['review'],
        image: data['image'] ?? '',
        images: data['images'] != null ? List<String>.from(data['images']) : [],
        categoryId: data['categoryId'] ?? '',
        isFavorite: data['isFavorite'] ?? false,
        feature: data['feature'] ?? '');
  }
}
