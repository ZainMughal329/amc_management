
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class diarySearchState{
  TextEditingController searchController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('diaryNumberRegister');


}