
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class dispatchState {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final recievedByController = TextEditingController();
  final notificationToController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('dispatchFile');
}