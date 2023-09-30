//
//
// class UserModel {
//   final String? id;
//   final String? fullName;
//   final String? email;
//   final String? password;
//    const UserModel({
//     this.id,
//      required this.email,
//      required this.fullName,
//      required this.password
//
// });
//
//    toJson(){
//      return {
//
//        "FullName":fullName,
//        "Email":email,
//        "Password":password
//      };
//    }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  final String email;
  final String username;
  final String password;
  String? profile;
  final String? status;
  // String status;

  UserModel({
    this.id = '',
    this.profile='',
    this.status="false",
     // required this.status=false,
    required this.email,
    required this.username,
    required this.password,
  });

  toJson() {
    return {
      'profile':profile,
      'status': "false",
      'id': id,
      'Email': email,
      'UserName': username,
      'Password': password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return UserModel(
      profile: data['profile'],
      id: data['id'],
      status: data["status"],
      email: data['Email'],
      username: data['UserName'],
      password: data['Password'],
    );
  }
}
