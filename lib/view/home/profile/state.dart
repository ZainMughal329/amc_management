import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class profileState{
  final namecontroller = TextEditingController();
  final phonecontroller=TextEditingController();
  final emailcontroller=TextEditingController();
  final emailfocousNode=FocusNode();
  final namefocousNode =FocusNode();
  final phonefocousNode = FocusNode();
  RxBool loading=false.obs;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final ref = FirebaseFirestore.instance;

  // final ref = FirebaseFirestore.instance.collection('users');
  // final pfRef = FirebaseFirestore.instance.collection('users').snapshots();
  final auth = FirebaseAuth.instance;
  //here we write code  to get the image from gallery or camera
  final picker = ImagePicker();
}