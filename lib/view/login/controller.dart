import 'package:amc_management/view/login/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/services/session_Controller.dart';
import '../../utils/routes/routes_name.dart';
class LoginController extends GetxController{
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.passwordController.dispose();
    state.emailController.dispose();
    state.emailfocous.dispose();
    state.passwordfocous.dispose();
  }
  final state =LoginState();
  LoginController();
  void LogIn(BuildContext context , String email,String password)async{

    try{
      state.auth.signInWithEmailAndPassword(email: email, password: password).then((value){

        SessionController().userid= value.user!.uid.toString();
        Get.toNamed(RouteNames.homeview);
      }).onError((error, stackTrace){
        Get.snackbar('Error',error.toString());
      });
    }catch(e){
      Get.snackbar('Error', e.toString());
    }

  }

}