import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class userViewState{
  final connection = false.obs;
  String? id = "";
  String dpName='';
  FirebaseAuth auth =FirebaseAuth.instance;
  List<String> imageUrls =[];
  final ref = FirebaseFirestore.instance;
  final searchController = TextEditingController();
  final editController =TextEditingController();
  final firestoreRef = FirebaseFirestore.instance.collection('diaryNumberRegister');
  final getDataRef = FirebaseFirestore.instance.collection('diaryNumberRegister').snapshots();
}