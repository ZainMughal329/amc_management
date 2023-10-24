



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customTextField extends StatelessWidget {
  final String hintText;
  String? lableText;
  final bool obscureText;
  IconData? icon;
  final IconData? suffixIcon;
  final VoidCallback? onPressSufix;
  TextInputType? keyboardType;
  final TextEditingController? controller;
  customTextField(
      {super.key,
        required this.hintText,
        this.lableText,
        this.obscureText = false,
        this.controller,
        this.icon,
        this.suffixIcon,
        this.keyboardType,
        this.onPressSufix});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 16.0.sp,
        color: Colors.black,
      ),
      decoration: InputDecoration(

        labelText: lableText,
        labelStyle: TextStyle(color: Colors.grey,fontSize: 20.sp,fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          onPressed: onPressSufix,
          icon: Icon(suffixIcon,color: Colors.grey,),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16.0.sp,
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}

