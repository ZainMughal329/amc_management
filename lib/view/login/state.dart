
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class LoginState{
  Rx<bool> loading = false.obs;
  FirebaseAuth auth =FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailfocous = FocusNode();
  final passwordfocous = FocusNode();
}