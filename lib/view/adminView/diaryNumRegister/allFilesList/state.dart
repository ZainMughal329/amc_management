import 'package:cloud_firestore/cloud_firestore.dart';

class allFilesState {
  final ref = FirebaseFirestore.instance.collection('diaryNumberRegister');
}