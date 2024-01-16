import 'package:amc_management/view/SessionView/login/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/services/session_Controller.dart';
import '../../../utils/routes/routes.dart';
import '../../../utils/snackBar.dart';
import '../../userView/view.dart';
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

  // function to setLoading for buttons
  void setLoading(bool value){
    state.loading.value = value;
  }

  void LogIn(BuildContext context , String email,String password)async{
    setLoading(true);
    try{
      state.auth.signInWithEmailAndPassword(email: email, password: password).then((value) async{
        setLoading(false);
        SessionController().userid= value.user!.uid.toString();
        state.deptName = await getuserDept(SessionController().userid.toString());
        Get.offAll(()=>userView(deptName: state.deptName));
        print(state.deptName.toString());
         state.emailController.clear();
         state.passwordController.clear();
      }).onError((error, stackTrace){
        // CustomSnackbar.showSnackbar(context, error.toString());
        // Snackbar2.showSnackBar('Error', error.toString());
        Get.snackbar('Error',error.toString(),backgroundColor:Colors.white ,colorText: Colors.blueGrey.withOpacity(.8));
        setLoading(false);
        // state.loading.value=false;
      });
    }catch(e){
      Get.snackbar('Error', e.toString());
      setLoading(false);
      // state.loading.value=false;
    }
  }


  Future<String> getuserDept(String id) async{
     DocumentSnapshot userData = await  state.ref.collection('users').doc(id).get();
     String deptName = userData['dept'];
     print(deptName.toString());
     return deptName;
  }

}