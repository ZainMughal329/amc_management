

import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/userModel/user_model.dart';
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


  void registerUserWithEmailAndPassword(
      UserModel userinfo, String email, password) async {
    try {
      print('inside try');
      var user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            print('inside then');
        userinfo.id = auth.currentUser!.uid.toString();
        createUser(userinfo);
      }).onError((error, stackTrace) {
        Get.snackbar('msg', error.toString());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('msg', e.toString());
    } catch (_) {
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
      Get.snackbar('msg', 'Successfully created account');

      Get.offAllNamed(RouteNames.userView);
    }).catchError((error, stackTrace) {
      Get.snackbar('msg', "Error occurred");
    });
  }

  void storeUser(
      UserModel user, BuildContext context, String email, String pass) async {
    registerUserWithEmailAndPassword(user, email, pass);
  }






}
