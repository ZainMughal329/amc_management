import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class listOfImagesState{
  List<String> imageUrls = [];
  RxInt imageNo = 0.obs;
  final loading = false.obs;
  final ref = FirebaseFirestore.instance.collection('diaryNumberRegister');
  final auth = FirebaseAuth.instance;
  DateTime selectedDate = DateTime.now();
  List<String> fetchedImageUrls = [];
  RxBool fetchedLoading = true.obs;
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();
  List<String> images = [];

}