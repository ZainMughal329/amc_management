


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class dataUploadState{
  final ref = FirebaseFirestore.instance.collection('Received Files');
  final detailController = TextEditingController();
  final detailFocusNode = FocusNode();
  final receiverNameController =TextEditingController();
  final receiverNameFocusNode=FocusNode();
  final receiverAddressController = TextEditingController();
  final receiverAddressFocusNode = FocusNode();
  final dateController = TextEditingController();
  final dateFocusNode =FocusNode();
  final receivedfromController = TextEditingController();
  final receivedFromFocusNode = FocusNode();
  final serialNumController = TextEditingController();
  final serialNumFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  RxBool loading = false.obs;
  RxBool loaded = false.obs;
  List<String> imageUrls = [];
  final RxBool isFormValid = false.obs;
  RxString serialNum = ''.obs;





}