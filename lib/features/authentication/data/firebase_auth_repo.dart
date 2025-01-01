import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/features/authentication/domain/entities/app_user.dart';
import 'package:fashion_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(), password: password);

      DocumentSnapshot userDoc = await firebaseFireStore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      AppUser user = AppUser(
          uid: userCredential.user!.uid,
          name: userDoc['name'] ?? 'Unknown',
          email: email,
          lastName: userDoc['lastName'] ?? 'Unknown');

      return user;
    } catch (e) {
      throw Exception('Failed to login : $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String lastName, String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);

      AppUser user = AppUser(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          lastName: lastName);

      await firebaseFireStore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      return user;
    } catch (e) {
      throw Exception('Failed to login : $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return null;
    }

    DocumentSnapshot userDoc =
        await firebaseFireStore.collection("users").doc(firebaseUser.uid).get();

    if (!userDoc.exists) {
      return null;
    }

    return AppUser(
        uid: firebaseUser.uid,
        name: userDoc['name'] ?? 'Unknown',
        lastName: userDoc['lastName'] ?? 'Unknown',
        email: firebaseUser.email!);
  }
}
