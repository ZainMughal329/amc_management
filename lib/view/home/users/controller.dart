

import 'package:amc_management/view/home/users/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class userController extends GetxController with GetSingleTickerProviderStateMixin{
  final state = userState();

  late TabController tabController;


  userController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

  }

  void deleteUsers(){
    // state.ref.

  }
}