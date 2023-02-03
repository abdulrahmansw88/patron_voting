import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  int? role;
  String? name;
  String? email;
  String? password;
  String? uid;

  UserData({this.role, this.name, this.email, this.password, this.uid});
  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return UserData(
      role: data!['role'],
      name: data["name"],
      email: data["email"],
      password: data["password"],
      uid: data["uid"],
    );
  }
  static UserData fromMap(Map<String, dynamic> user) {
    return  UserData(
      role: user['role'],
      name: user["name"],
      email: user["email"],
      password: user["password"],
      uid: user["uid"],
    );
  }

  toMap() {
    return {
      "role": role,
      "name": name,
      "email": email,
      "password": password,
      "uid": uid,
    };
  }
}