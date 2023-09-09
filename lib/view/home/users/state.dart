
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userState{
  
  final ref = FirebaseFirestore.instance.collection('users').snapshots();
  FirebaseAuth auth = FirebaseAuth.instance;
  
}