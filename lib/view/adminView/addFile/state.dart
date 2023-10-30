





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addFileState{
 final ref = FirebaseFirestore.instance.collection('addFiles');
 final auth = FirebaseAuth.instance;
 var deptName = 'Select'.obs;
 final loading = false.obs;
 final detailController = TextEditingController();
 final detailFocusNode = FocusNode();
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
 DateTime selectedDate = DateTime.now();
  final dateController = TextEditingController();
  final dateFocusNode =FocusNode();
  final fromController = TextEditingController();
  final fromFocusNode = FocusNode();
  final filenoController = TextEditingController();
  final filenoFocusNode = FocusNode();
}