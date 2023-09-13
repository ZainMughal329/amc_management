import 'dart:io';
import 'package:amc_management/res/colors.dart';
import 'package:amc_management/view/home/addFile/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../model/addFile_model/addFile_model.dart';
import '../../../res/components/custom_button.dart';
class addFileView extends GetView<addFileController> {
  const addFileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              Obx((){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Obx(()=>Container(
                        height: 200,
                        width: 200,

                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            )
                          //   image: DecorationImage(
                          //       fit: BoxFit.cover,
                          //       image: controller.imagePath.isNotEmpty?FileImage(File(controller.imagePath.toString())))
                        ),
                        child: controller.imagePath == ''
                            ? Icon(Icons.image)
                            : Image(
                            fit: BoxFit.cover,
                            image: FileImage(
                                File(controller.imagePath.toString())))),),
                    // Center(
                    //   child: CircleAvatar(
                    //       radius: 50,
                    //       backgroundImage:controller.imagePath.isNotEmpty?
                    //       FileImage(File(controller.imagePath.toString())):
                    //       null
                    //   ),
                    // ),
                    controller.imagePath == '' ? Center(
                      child: TextButton(onPressed: (){
                        controller.pickImage(context);
                      }, child: Text('Pick Image')),
                    ) : Container(),
                  ],
                );
              }),
              SizedBox(height: 15,),
              customTextField(hintText: 'Name', controller: controller.state.nameController),
              SizedBox(height: 10,),
              customTextField(hintText: 'Date', controller: controller.state.dateController),
              SizedBox(height:10,),
              customTextField(hintText: 'File No', controller: controller.state.filenoController),
              SizedBox(height: 10,),
              customTextField(hintText: 'From', controller: controller.state.fromController),
              SizedBox(height: 10,),
              ReuseButton(tittle: 'Upload', onpress: (){

                 final addFile = AddFileModel(name: controller.state.nameController.text.trim(),
                     date: controller.state.dateController.text.trim(),
                     from: controller.state.fromController.text.trim(),
                     filenum: controller.state.filenoController.text.trim(),
                 image: controller.imagePath.toString()
                 );
                 controller.storeData(addFile, context, controller.state.nameController.text.trim(),
                     controller.state.fromController.text.trim(),
                     controller.imagePath.toString(),
                     controller.state.filenoController.text.trim(),
                     controller.state.dateController.text.trim());
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
