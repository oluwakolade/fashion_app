import 'package:fashion_app/features/authentication/domain/entities/app_user.dart';

class User extends AppUser {
  final List<String> favorites;
  final List<String> address;
  final List<String> cardNumber;

  User({
    required super.uid,
    required super.email,
    required super.name,
    required super.lastName,
    this.address = const [],
    this.cardNumber = const [],
    this.favorites = const [],
    // required this.profilePhoto,
  });

  User copyWith(
      {
      // String? newAddress,
      List<String>? newAddress,
      List<String>? newCardNumber,
      List<String>? newFav}) {
    return User(
      uid: uid,
      email: email,
      lastName: lastName,
      name: name,
      address: newAddress ?? address,
      cardNumber: newCardNumber ?? cardNumber,
      favorites: newFav ?? favorites,
      // required this.profilePhoto,
      // profilePhoto: newProfilePhoto ?? profilePhoto,
    );
  }

  //convert to json

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'lastName': lastName,
      'address': address,
      'cardNumber': cardNumber,
      'favorites': favorites
    };
  }

  //covert json to profile user
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      // profilePhoto: json['profilePhoto'] ?? '',
      lastName: json['lastName'] ?? '',
      // address: json['address'] ?? '',
      address:
          json['address'] != null ? List<String>.from(json['address']) : [],
      cardNumber: json['cardNumber'] != null
          ? List<String>.from(json['cardNumber'])
          : [],
      favorites:
          json['favorites'] != null ? List<String>.from(json['favorites']) : [],
    );
  }
}
