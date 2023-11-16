
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotState{

  final auth = FirebaseAuth.instance;
  final loading = false.obs;

  final emailcontroller = TextEditingController();
  final Emailfocousnode = FocusNode();
}