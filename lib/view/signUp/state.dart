import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class SignupState{
  // final dbFireStore = FirebaseFirestore.instance.collection('Users').snapshots();
  final dbFireStore = FirebaseFirestore.instance.collection('users');
  // RxBool loading = false.obs;
  final emailcontroller = TextEditingController();
  final passwordcontroller= TextEditingController();
  final usernamecontroller=TextEditingController();
  final Emailfocousnode = FocusNode();
  final Passwordfocusnode=FocusNode();
  final usernamefocousnode=FocusNode();
}