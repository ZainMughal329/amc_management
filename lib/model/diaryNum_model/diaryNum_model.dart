import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryNumModel {
  final String id;
  final List<String> images;
  // final String name;
  final String serialNum;
  final   DateTime? date;
  final DateTime? fileDispatchDate;
  final String recieverName;
  final String senderAddress;
  final String senderName;
  final String? subject;
  final String letterNum;
  final String dept;
  DiaryNumModel({
    required this.id,
    required this.images,
    this.subject,
    required this.letterNum,
    required this.dept,
    required this.senderName,
    // required this.name,
    this.date,
    this.fileDispatchDate,
    required this.recieverName,
    required this.senderAddress,
    required this.serialNum,
  });

  toJson() {
    return {
      'Id':id,
      'subject':subject,
      'Image': images,
      'Dept':dept,
      'letterNum':letterNum,
      'serialNum': serialNum,
      'recieverName': recieverName,
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
      letterNum: data['letterNum'],
      serialNum: data['serialNum'],
      recieverName: data['recieverName'],
      senderAddress: data['senderAddress'],
      date: data['Date'],

    );
  }
}
