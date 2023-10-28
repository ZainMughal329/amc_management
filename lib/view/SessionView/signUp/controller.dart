

import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/userModel/user_model.dart';
import 'index.dart';

class SignupController extends GetxController
     {
  final state = SignupState();

  SignupController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.emailcontroller.dispose();
    state.Emailfocousnode.dispose();
    state.passwordcontroller.dispose();
    state.Passwordfocusnode.dispose();
    state.usernamecontroller.dispose();
    state.usernamefocousnode.dispose();
  }



  final auth = FirebaseAuth.instance;
  final _dbUser = FirebaseFirestore.instance.collection('users');

  void setLoading(bool value){
    state.loading.value = value;
  }
  void registerUserWithEmailAndPassword(
      UserModel userinfo, String email, password) async {
    setLoading(true);
    try {
      var user = await auth
          .createUserWithEmailAndPassword(email: email, password: password,
      )
          .then((value) {
        setLoading(false);
        userinfo.id = auth.currentUser!.uid.toString();
        createUser(userinfo);
      }).onError((error, stackTrace) {
        setLoading(false);

        Get.snackbar('msg', error.toString());
      });
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      Get.snackbar('msg', e.toString());
    } catch (_) {
      setLoading(false);
    }
  }




  Future<UserModel> getUserData(String email) async {
    final snapshot = await _dbUser.where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  createUser(UserModel user) async {
    await _dbUser
        .doc(auth.currentUser!.uid)
        .set(user.toJson())
        .whenComplete(() {
      Get.snackbar('Message', 'Registered Successfully');
      Get.offAllNamed(RouteNames.userView);
    }).catchError((error, stackTrace) {
      Get.snackbar('Message', "Error occurred");
    });
  }

  void storeUser(
      UserModel user, BuildContext context, String email, String pass,String dept) async {
    registerUserWithEmailAndPassword(user, email, pass);
  }






}
