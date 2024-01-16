import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class dispatchState {
  final subjectController = TextEditingController();
  final subjectFocousNode = FocusNode();
  final markByController = TextEditingController();
  final markByFocusNode = FocusNode();
  final letterNumController = TextEditingController();
  final letterNumFocusNode = FocusNode();
  final serialNumcontroller = TextEditingController();
  final serialnumFocousNode = FocusNode();
  final receiverNameController = TextEditingController();
  final receiverNameFocousNode = FocusNode();
  final receiverAddressController = TextEditingController();
  final receiverAddressFocousNode = FocusNode();
  final dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  final ref = FirebaseFirestore.instance.collection('dispatchFile');
  // var deptName = 'Select'.obs;
  RxInt imageNo = 0.obs;
  RxBool loading = false.obs;
  final auth = FirebaseAuth.instance;
  final RxBool isFormValid = false.obs;
  List<String> imageUrls = [];
  RxBool loaded = false.obs;
  RxString serialNum = ''.obs;
  RxString letterNum = ''.obs;
  RxString receiverName = ''.obs;
  RxString receiverAddress = ''.obs;
  RxString fileSubject = ''.obs;




}