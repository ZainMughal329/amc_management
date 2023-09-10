import 'package:cloud_firestore/cloud_firestore.dart';

class AddFileModel {
  final String? image;
  final String name;
  final   String date;
  // final String username;
  // final String pkgStartDate;
  final String from;
  // final String pkgType;
  final String filenum;
  // final String address;
  // final String deviceToken;

  AddFileModel({
    this.image,
    required this.name,
    required this.date,
    required this.from,
    required this.filenum,
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
      'From': from,
      'FileNum': filenum,
      'Date': date,
      // 'pkgEndDate': pkgEndDate,
      // 'pkgType': pkgType,
      // 'Password': password,
      // 'address': address,
      // 'deviceToken': deviceToken,
    };
  }

  factory AddFileModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return AddFileModel(
      image:data['image'],
      name: data['Name'],
      from: data['From'],
      filenum: data['FileNum'],
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
