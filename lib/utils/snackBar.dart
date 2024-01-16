import 'package:amc_management/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Snackbar {
  static void showSnackBar(String title, String message) {
    Get.snackbar(title, message,
        colorText: Colors.black,
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        backgroundColor: AppColors.lightTextFormFieldColor.withOpacity(0.2));
  }
}

class Snackbar2 {
  static void showSnackBar (String title, String msg,IconData iconData){
    String message = extractErrorMessage(msg);
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.blueGrey.withOpacity(.8), // dark grey background
      colorText: Colors.white,
      titleText: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white
          // for a splash of color
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white

        ),
      ),
      icon: Icon(
        iconData,
        color: Colors.white,
        size: 25,

      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      margin: EdgeInsets.all(10),
      forwardAnimationCurve: Curves.easeOutExpo,
      reverseAnimationCurve: Curves.easeInOut,
    );


  }


  static String extractErrorMessage(String error) {
    if (error.contains(']')) {
      return error.split(']').last.trim();
    }
    return error; 
    }
}

class CustomSnackbar {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              message,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            backgroundColor: Colors.blueGrey,
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
              textColor: Colors.white,
            ),
        ),
        );
 }
}