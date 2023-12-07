
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class listOfImagestate{
  List<String> imageUrls = [];
  RxInt imageNo = 0.obs;
  final loading = false.obs;
  final ref = FirebaseFirestore.instance.collection('Received Files');
  final auth = FirebaseAuth.instance;
  List<String> fetchedImageUrls = [];
  RxBool fetchedLoading = true.obs;
  DateTime selectedDate = DateTime.now();
  List<String> images = [];



}