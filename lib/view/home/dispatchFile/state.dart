import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class dispatchState {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final markByController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final recievedByController = TextEditingController();
  final notificationToController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('dispatchFile');


  var deptName = 'Select'.obs;


  // final List<String> listItem = [
  //   "Principle",
  //   "It",
  //   "Math",
  //   "English",
  //   "Urdu",
  //   "Physics",
  //   "Chemistry",
  //   "Ecnomics",
  //   "Biology"
  // ];
  // List<DropdownMenuItem> listDepts = <DropdownMenuItem>[
  //   DropdownMenuItem(
  //     value: 'principle',
  //     child: Text('Principle'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'IT',
  //     child: Text('IT'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'english',
  //     child: Text('English'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'math',
  //     child: Text('Math'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'physics',
  //     child: Text('Physics'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'economics',
  //     child: Text('Economics'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'biology',
  //     child: Text('Biology'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'urdu',
  //     child: Text('Urdu'),
  //   ),
  //   DropdownMenuItem(
  //     value: 'chemistry',
  //     child: Text('Chemistry'),
  //   ),
  // ];
}
