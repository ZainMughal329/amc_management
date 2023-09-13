

import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'index.dart';

class ForgotController extends GetxController{
  final state = ForgotState();
  ForgotController();


  void forgotPassword(BuildContext context , String email)async{

    try{
      state.auth.sendPasswordResetEmail(email: email).then((value) {
        Get.toNamed(RouteNames.loginview);
        Get.snackbar('Sucess', 'Check your email to recover your password');

      }).onError((error, stackTrace) {
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      Get.snackbar('Error', e.toString());
    }


  }
}