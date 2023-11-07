import 'package:cloud_firestore/cloud_firestore.dart';

class DispatchModel {
  final String id;
  final List<String> images;
  final String name;
  final String? detail;
  final String filenum;
  final   DateTime date;
  final String dept;
  // final String username;
  // final String pkgStartDate;
  final String recievedBy;
  // final String pkgType;
  final String notificationTo;
  // final String address;
  // final String deviceToken;

  DispatchModel({
    required this.id,
    required this.images,
    this.detail,
    required this.dept,
    required this.name,
    required this.date,
    required this.recievedBy,
    required this.notificationTo,
    required this.filenum,
    // required this.pkgEndDate,
    // required this.pkgType,
    // required this.password,
    // required this.address,
    // required this.deviceToken,
  });

  toJson() {
    return {
      'Id':id,
      'Detail':detail,
      'Image': images,
      'Dept':dept,
      'Name': name,
      'FileNum': filenum,
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
      id: data['Id'],
      detail: data['Detail'],
      dept: data['dept'],
      images:data['image'],
      name: data['Name'],
      filenum: data['FileNum'],
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
