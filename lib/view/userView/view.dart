


import 'package:amc_management/view/userView/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class userView extends GetView<userViewController> {
  const userView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Kindly wait for the approval',
        style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
