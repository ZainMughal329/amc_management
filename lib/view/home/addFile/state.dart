





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addFileState{
 final ref = FirebaseFirestore.instance.collection('addFiles');
 final auth = FirebaseAuth.instance;
  final nameController = TextEditingController();
 DateTime selectedDate = DateTime.now();
  final dateController = TextEditingController();
  final fromController = TextEditingController();
  final filenoController = TextEditingController();
}