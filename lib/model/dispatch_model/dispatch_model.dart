import 'package:cloud_firestore/cloud_firestore.dart';

class DispatchModel {
  final String id;
  final List<String> images;
  // final String name;
  final String serialNum;
  final   DateTime? date;
  final String recieverName;
  final String receiverAddress;
  final String? subject;
  final String letterNum;
  // final String dept;
  DispatchModel({
    required this.id,
    required this.images,
    this.subject,
    required this.letterNum,
    // required this.dept,
    // required this.name,
     this.date,
    required this.recieverName,
    required this.receiverAddress,
    required this.serialNum,
  });

  toJson() {
    return {
      'Id':id,
      'subject':subject,
      'Image': images,
      // 'Dept':dept,
      'letterNum':letterNum,
      'serialNum': serialNum,
      'recieverName': recieverName,
      'receiverAddress': receiverAddress,
      'Date': date,
    };
  }

  factory DispatchModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return DispatchModel(
      id: data['Id'],
      subject: data['subject'],
      // dept: data['dept'],
      images:data['image'],
      letterNum: data['letterNum'],
      serialNum: data['serialNum'],
      recieverName: data['recieverName'],
      receiverAddress: data['receiverAddress'],
      date: data['Date'],

    );
  }
}
