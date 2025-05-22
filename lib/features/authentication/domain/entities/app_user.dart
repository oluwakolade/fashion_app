class AppUser {
  final String uid;
  final String name;
  final String email;
  final String lastName;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.lastName,
  });

  //convert to json
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'name': name, 'email': email, 'lastName': lastName};
  }

  //convert json to app user
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      name: jsonUser['name'],
      email: jsonUser['email'],
      lastName: jsonUser['lastName'],
    );
  }
}
