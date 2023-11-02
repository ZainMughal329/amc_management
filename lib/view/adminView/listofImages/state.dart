import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListOfFileState {

  final ref = FirebaseFirestore.instance.collection('addFiles');
  RxInt imageNo = 0.obs;
}