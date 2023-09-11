


import 'dart:io';

import 'package:amc_management/model/dispatch_model/dispatch_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../res/components/custom_button.dart';
import 'index.dart';

class dispatchView extends GetView<dispatchController> {
  const dispatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15,),
                Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryIconColor,
                      child: IconButton(
                          onPressed: (){
                            Get.back();
                          }, icon: Icon(Icons.arrow_back,
                        color: Colors.white,
                      )),
                    )),
                Obx(() =>
                  Container(
                      height: 200,
                      width: 200,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //       fit: BoxFit.cover,
                      //       image: controller.imagePath.isNotEmpty?FileImage(File(controller.imagePath.toString())))
                      // ),
                      child:
                      controller.imagePath== null ?
                      Icon(Icons.file_copy) :
                      Image(
                          fit: BoxFit.cover,
                          image: FileImage(File(controller.imagePath.toString()))
                      )
                  ),
                ),
                Center(
                  child: TextButton(onPressed: (){
                    controller.getImage();
                  }, child: Text('Pick Image')),
                )
              ],
            ),
                SizedBox(height: 20,),
                customTextField(hintText: 'Name', controller: controller.state.nameController),
                SizedBox(
                  height: 10,
                ),
                customTextField(hintText: 'date', controller: controller.state.dateController),
                SizedBox(height: 10,),
                customTextField(hintText: 'recievedBy', controller: controller.state.recievedByController),
                SizedBox(height: 10,),
                customTextField(hintText: 'notificationTo', controller: controller.state.notificationToController),
                SizedBox(height: 20,),
                ReuseButton(tittle: 'Dispatch', onpress: (){

                  final dispatch = DispatchModel(name: controller.state.nameController.text.trim(),
                      date: controller.state.dateController.text.trim(),
                      recievedBy: controller.state.recievedByController.text.trim(),
                      notificationTo: controller.state.notificationToController.text.trim(),
                  image: controller.imagePath.toString()
                  );
                  controller.storeData(dispatch, context,controller.imagePath.toString() ,
                  controller.state.nameController.text.trim(),
                   controller.state.recievedByController.text.trim(),
                      controller.state.notificationToController.text.trim(),
                    controller.state.dateController.text.trim(),

                  );

                })
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class customTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  customTextField({super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16.0,
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
    );
  }
}

//controller.imagePath == null
//                               ? Image(
//                                   image: FileImage(
//                                       File(controller.imagePath.toString())))
//                               : Icon(Icons.image_aspect_ratio)),