import 'package:cloud_firestore/cloud_firestore.dart';

class DispatchModel {
  final String? image;
  final String name;
  final String date;
  // final String username;
  // final String pkgStartDate;
  final String recievedBy;
  // final String pkgType;
  final String notificationTo;
  // final String address;
  // final String deviceToken;

  DispatchModel({
    this.image,
    required this.name,
    required this.date,
    required this.recievedBy,
    required this.notificationTo,
    // required this.pkgEndDate,
    // required this.pkgType,
    // required this.password,
    // required this.address,
    // required this.deviceToken,
  });

  toJson() {
    return {
      'Image': image,
      'Name': name,
      'RecievedBy': recievedBy,
      'NotificationTo': notificationTo,
      'Date': date,
      // 'pkgEndDate': pkgEndDate,
      // 'pkgType': pkgType,
      // 'Password': password,
      // 'address': address,
      // 'deviceToken': deviceToken,
    };
  }

  factory DispatchModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return DispatchModel(
      image:data['image'],
      name: data['Name'],
      recievedBy: data['RecievedBy'],
      notificationTo: data['NotificationTo'],
      date: data['Date'],
      // pkgStartDate: data['pkgStartDate'],
      // pkgEndDate: data['pkgEndDate'],
      // pkgType: data['pkgType'],
      // address: data['address'],
      // password: data['Password'],
      // deviceToken: data['deviceToken'],
    );
  }
}
