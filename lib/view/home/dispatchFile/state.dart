
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class dispatchState {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final markByController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final recievedByController = TextEditingController();
  final notificationToController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('dispatchFile');
  var deptName = ''.obs;
   final List<String> listItem=[
    "Principle","It","Math","English","Urdu","Physics","Chemistry","Ecnomics","Biology"
  ];
}