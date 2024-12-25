import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String name;
  final String id;
  final String image;

  Category({
    required this.name,
    required this.id,
    required this.image,
  });

  Category copyWith({String? image}) {
    return Category(
      name: name,
      id: id,
      image: image ?? this.image,
    );
  }

  static Category empty() => Category(
        name: '',
        id: '',
        image: '',
      );

// Convert Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'image': image,
    };
  }

  // Factory to create Category from JSON (Firestore or any JSON source)
  factory Category.fromJson(Map<String, dynamic> json, {String? documentId}) {
    return Category(
      id: documentId ?? json['id'] ?? '',
      name: json['name'] ?? 'No name',
      image: json['image'] ?? 'assets/logo.png',
    );
  }

  // Factory to create Category from Firestore DocumentSnapshot
  factory Category.fromFirestore(QueryDocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Category(
      id: snapshot.id,
      name: data['name'] ?? 'No name',
      image: data['image'] ?? 'assets/logo.png',
    );
  }
}
