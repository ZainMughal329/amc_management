import 'package:cloud_firestore/cloud_firestore.dart';

class AddFileModel {
  final String? image;
  // final String? id;
  final String name;
  final   String date;
  final String dept;
  // final String username;
  // final String pkgStartDate;
  final String from;
  // final String pkgType;
  final String filenum;
  // final String address;
  // final String deviceToken;

  AddFileModel({
    this.image,
    // this.id,
    required this.name,
    required this.dept,
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
      // 'Id':id,
      'dept':dept,
      'Image': image,
      'Name': name,
      'From': from,
      'FileNum': filenum,
      'Date': date,
    };
  }

  factory AddFileModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return AddFileModel(
      // id: data['Id'],
      dept: data['dept'],
      image:data['Image'],
      name: data['Name'],
      from: data['From'],
      filenum: data['FileNum'],
      date: data['Date'],
    );
  }
}
