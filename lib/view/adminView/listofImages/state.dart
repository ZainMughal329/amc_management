import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfFileState {

  final ref = FirebaseFirestore.instance.collection('addFiles');
}