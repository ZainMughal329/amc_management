



import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../model/services/session_Controller.dart';
import '../../utils/routes/routes_name.dart';

class SplashController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLogin();
  }

  void isLogin(){
    FirebaseAuth auth =FirebaseAuth.instance;
    final user =auth.currentUser;
    if(user!=null){
      //mean if uer is already login then it directly go to home screen app the splash screen
      SessionController().userid= user.uid.toString();
      Timer(const Duration(seconds: 3),()=> Get.offAllNamed(RouteNames.homeview));
    }else{
      Timer( const Duration(seconds: 3),()=> Get.toNamed(RouteNames.loginview));
    }
  }

}