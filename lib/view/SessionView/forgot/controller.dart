

import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'index.dart';

class ForgotController extends GetxController{
  final state = ForgotState();
  ForgotController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.Emailfocousnode.dispose();
    state.emailcontroller.dispose();
  }
  void setLoading(bool value){
    state.loading.value = value;
  }

  void forgotPassword(BuildContext context , String email)async{
    setLoading(true);
    try{
      state.auth.sendPasswordResetEmail(email: email).then((value) {
        setLoading(false);
        Get.toNamed(RouteNames.loginview);
        Get.snackbar('Sucess', 'Check your email to recover your password');

      }).onError((error, stackTrace) {
        setLoading(false);
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      setLoading(false);
      Get.snackbar('Error', e.toString());
    }


  }
}