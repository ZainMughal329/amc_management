import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryNumModel {
  final String id;
  final List<String> images;
  // final String name;
  final String serialNum;
  final   DateTime? date;
  final DateTime? fileDispatchDate;
  final String receiverName;
  final String senderAddress;
  final String senderName;
  final String? subject;
  List<dynamic> dept;
  DiaryNumModel({
    required this.id,
    required this.images,
    this.subject,
    required this.dept,
    required this.senderName,
    // required this.name,
    this.date,
    this.fileDispatchDate,
    required this.receiverName,
    required this.senderAddress,
    required this.serialNum,
  });

  toJson() {
    return {
      'Id':id,
      'subject':subject,
      'Image': images,
      'Dept':dept,
      'serialNum': serialNum,
      'receiverName': receiverName,
      'senderAddress': senderAddress,
      'senderName': senderName,
      'Date': date,
      'fileDispatchDate': fileDispatchDate,
    };
  }

  factory DiaryNumModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return DiaryNumModel(
      id: data['Id'],
      subject: data['subject'],
      dept: data['dept'],
      fileDispatchDate: data['fileDispatchDate'],
      senderName: data['senderName'],
      images:data['image'],
      serialNum: data['serialNum'],
      receiverName: data['receiverName'],
      senderAddress: data['senderAddress'],
      date: data['Date'],

    );
  }
}
