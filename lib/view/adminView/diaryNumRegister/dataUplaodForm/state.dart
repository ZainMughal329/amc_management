import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class dataUploadState{
  final ref = FirebaseFirestore.instance.collection('diaryNumberRegister');
  List<String> imageUrls = [];
  RxBool loaded = false.obs;
  RxBool loading = false.obs;
 final serialNumController = TextEditingController();
 final serialNumFocus = FocusNode();
 final dateController = TextEditingController();
 final dateFocus = FocusNode();
 final fileDispatchDateController = TextEditingController();
 final fileDispatchDateFocus = FocusNode();
 final senderNameController = TextEditingController();
 final senderNameFocus = FocusNode();
 final senderAddressController = TextEditingController();
 final senderAddressFocus = FocusNode();
 final fileSubjectController = TextEditingController();
 final fileSubjectFocus = FocusNode();
 final receiverNameController = TextEditingController();
 final receiverNameFocus = FocusNode();
 DateTime selectedDate = DateTime.now();
 DateTime dispatchSelDate = DateTime.now();
 var deptName = 'Select'.obs;
}