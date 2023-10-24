
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ForgotState{

  final auth = FirebaseAuth.instance;

  final emailcontroller = TextEditingController();
  final Emailfocousnode = FocusNode();
}