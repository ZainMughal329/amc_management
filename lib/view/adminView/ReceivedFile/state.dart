





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class receivedFileState{

 RxInt imageNo = 0.obs;
 final ref = FirebaseFirestore.instance.collection('Received Files');
 final auth = FirebaseAuth.instance;
 var deptName = 'Select'.obs;
 final loading = false.obs;
 final detailController = TextEditingController();
 final detailFocusNode = FocusNode();
  final receiverNameController =TextEditingController();
  final receiverNameFocusNode=FocusNode();
  final receiverAddressController = TextEditingController();
  final receiverAddressFocusNode = FocusNode();
 DateTime selectedDate = DateTime.now();
 List<String> imageUrls = [];
  final dateController = TextEditingController();
  final dateFocusNode =FocusNode();
  final receivedfromController = TextEditingController();
  final receivedFromFocusNode = FocusNode();
  final serialNumController = TextEditingController();
  final serialNumFocusNode = FocusNode();
 final RxBool isFormValid = false.obs;
 // RxString nameFile = ''.obs;
 RxString serialNum = ''.obs;
 RxBool loaded = false.obs;


}