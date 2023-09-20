

import 'package:amc_management/view/home/users/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class userApproval extends GetView<userController> {
  const userApproval({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        height: 200,
        width: 200,
        child: Icon(Icons.person),
      ),
    );
  }
}
