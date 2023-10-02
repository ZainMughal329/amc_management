import 'package:amc_management/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbar {
  static void showSnackBar(String title, String message) {
    Get.snackbar(title, message,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        backgroundColor: AppColors.lightGrayColor.withOpacity(0.2));
  }
}
