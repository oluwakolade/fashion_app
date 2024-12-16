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

//   Category copyWith({String? image}) {
//     return Category(
//       name: name,
//       id: id,
//       image: image ?? this.image,
//     );
//   }

  static Category empty() => Category(name: '', id: '', image: '');

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'image': image,
    };
  }

  factory Category.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return Category(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
      );
    } else {
      return Category.empty();
    }
  }
}
