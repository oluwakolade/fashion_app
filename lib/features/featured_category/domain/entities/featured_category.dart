import 'package:cloud_firestore/cloud_firestore.dart';

class FeaturedCategory {
  final String name;
  final String id;

  FeaturedCategory({
    required this.name,
    required this.id,
  });

  FeaturedCategory copyWith({String? image}) {
    return FeaturedCategory(
      name: name,
      id: id,
    );
  }

  static FeaturedCategory empty() => FeaturedCategory(
        name: '',
        id: '',
      );

// Convert FeaturedCategory to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  // Factory to create FeaturedCategory from JSON (Firestore or any JSON source)
  factory FeaturedCategory.fromJson(Map<String, dynamic> json,
      {String? documentId}) {
    return FeaturedCategory(
      id: documentId ?? json['id'] ?? '',
      name: json['name'] ?? 'No name',
    );
  }

  // Factory to create FeaturedCategory from Firestore DocumentSnapshot
  factory FeaturedCategory.fromFirestore(
      QueryDocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return FeaturedCategory(
      id: snapshot.id,
      name: data['name'] ?? 'No name',
    );
  }
}
