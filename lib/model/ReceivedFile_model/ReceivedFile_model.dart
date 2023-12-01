import 'package:cloud_firestore/cloud_firestore.dart';

class ReceivedFileModel {
  final String id;
  // final String name;
  final  DateTime? date;
  final String dept;
  // final String? detail;
  final String receivedFrom;
  final String receivedAddress;
  final String receivereName;
  final String SerialNum;
  final List<String> images;


  ReceivedFileModel({
    required this.id,
    // this.detail,
    required this.receivedAddress,
    required this.receivereName,
    // required this.name,
    required this.dept,
    this.date,
    required this.receivedFrom,
    required this.SerialNum,
    required this.images,
  });

  toJson() {
    return {
       'Id':id,
      // 'Detail':detail,
      'receivedAddress':receivedAddress,
      'receiverName':receivereName,
      'dept':dept,
      // 'Name': name,
      'receivedFrom': receivedFrom,
      'serialNum': SerialNum,
      'Date': date,
      'images' : images
    };
  }

  factory ReceivedFileModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return ReceivedFileModel(
       id: data['Id'],
      // detail: data['Detail'],
      dept: data['dept'],
      // name: data['Name'],
      receivedFrom: data['receivedFrom'],
      SerialNum: data['serialNum'],
      receivedAddress: data['receivedAddress'],
      receivereName: data['receiverName'],
      date: data['Date'],
      images: ['images'],
    );
  }
}
