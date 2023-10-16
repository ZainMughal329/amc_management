import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class userViewState{
  final connection = false.obs;
  String? id = "";
  String dpName='';
  FirebaseAuth auth =FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance;
  final firestoreRef = FirebaseFirestore.instance.collection('addFiles');
  final getDataRef = FirebaseFirestore.instance.collection('addFiles').snapshots();
}