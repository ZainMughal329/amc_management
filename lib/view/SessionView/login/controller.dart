import 'package:amc_management/view/SessionView/login/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/services/session_Controller.dart';
import '../../../utils/routes/routes.dart';
import '../../userView/index.dart';
class LoginController extends GetxController{
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.passwordController.dispose();
    state.emailController.dispose();
    state.Emailfocousnode.dispose();
    state.Passwordfocusnode.dispose();
  }
  final state =LoginState();
  LoginController();
  void LogIn(BuildContext context , String email,String password)async{
    state.loading=true.obs;
    try{
      state.auth.signInWithEmailAndPassword(email: email, password: password).then((value) async{
        SessionController().userid= value.user!.uid.toString();
        state.deptName = await getuserDept(SessionController().userid.toString());
        Get.offAll(()=>userView(deptName: state.deptName));
        print(state.deptName.toString());
         state.emailController.clear();
         state.passwordController.clear();
         state.loading.value;
      }).onError((error, stackTrace){
        Get.snackbar('Error',error.toString());
        state.loading.value;
      });
    }catch(e){
      Get.snackbar('Error', e.toString());
      state.loading.value;
    }
  }


  Future<String> getuserDept(String id) async{
     DocumentSnapshot userData = await  state.ref.collection('users').doc(id).get();
     String deptName = userData['dept'];
     print(deptName.toString());
     return deptName;
  }

}