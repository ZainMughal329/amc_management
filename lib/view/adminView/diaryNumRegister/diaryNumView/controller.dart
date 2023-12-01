


import 'package:amc_management/view/adminView/diaryNumRegister/diaryNumView/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class diaryNumberController extends GetxController with GetSingleTickerProviderStateMixin{

  final state = diaryNumberState();
  late TabController tabController;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

}