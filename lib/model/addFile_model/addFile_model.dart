import 'package:cloud_firestore/cloud_firestore.dart';

class AddFileModel {
  final String id;
  final String name;
  final   DateTime? date;
  final String dept;
  final String? detail;
  // final String username;
  // final String pkgStartDate;
  final String from;
  // final String pkgType;
  final String filenum;
  // final String address;
  // final String deviceToken;
  final List<String> images;


  AddFileModel({
    required this.id,
    this.detail,
    required this.name,
    required this.dept,
    this.date,
    required this.from,
    required this.filenum,
    required this.images,

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
      'dept':dept,
      // 'Image': image,
      'Name': name,
      'From': from,
      'FileNum': filenum,
      'Date': date,
      'images' : images
    };
  }

  factory AddFileModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return AddFileModel(
       id: data['Id'],
      detail: data['Detail'],
      dept: data['dept'],
      // image:data['Image'],
      name: data['Name'],
      from: data['From'],
      filenum: data['FileNum'],
      date: data['Date'],
      images: ['images'],
    );
  }
}
