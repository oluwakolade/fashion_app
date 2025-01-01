import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:fashion_app/features/settings/domain/entities/user.dart';
import 'package:fashion_app/features/settings/domain/repo/user_settings_repo.dart';

class FirebaseUserSettings implements SettingsRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  @override
  Future<User?> fetchUserProfile(String uid) async {
    try {
      final userDoc =
          await firebaseFirestore.collection("users").doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return User.fromJson({
            ...userData,
            'uid': uid,
          });

          //  User(
          //     uid: uid,
          //     name: userData['name'],
          //     email: userData['email'],
          //     lastName: userData['lastName'],
          //     address: userData['address'] ?? 'No address',
          //     cardNumber: userData['cardNumber'] ?? 'No card number'

          //     // profilePhoto: userData['profilePhoto'].toString(),
          //     );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
//get user address and card number

  @override
  Future<void> updateUserProfile(User updateUser) async {
    try {
      final updateData = updateUser.toJson();
      await firebaseFirestore.collection('users').doc(updateUser.uid).update({
        'address': updateData['address'] ?? [],
        'cardNumber': updateData['cardNumber'] ?? [],
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> toggleFavorite(String uid, String id) async {
    try {
      final userDoc = usersCollection.doc(uid);
      final userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        List<String> favorites = List<String>.from(userData['favorites'] ?? []);

        if (favorites.contains(id)) {
          favorites.remove(id);
        } else {
          favorites.add(id);
        }

        await userDoc.update({'favorites': favorites});
      } else {
        throw Exception('User with ID $uid does not exist.');
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }

  @override
  Future<List<Products>> getUserFavorites(String uid) async {
    try {
      final userDoc = await usersCollection.doc(uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final favorites = List<String>.from(userData['favorites'] ?? []);

        if (favorites.isEmpty) {
          return [];
        }

        final snapshot = await productsCollection
            .where(FieldPath.documentId, whereIn: favorites)
            .get();

        return snapshot.docs.map((doc) => Products.fromFirestore(doc)).toList();
      } else {
        throw Exception('User with ID $uid not found.');
      }
    } catch (e) {
      throw Exception('Failed to fetch user favorites: $e');
    }
  }
}


// updateUser.toJson()