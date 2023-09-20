import 'dart:io';
import 'package:amc_management/res/colors.dart';
import 'package:amc_management/view/home/addFile/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/addFile_model/addFile_model.dart';
import '../../../res/components/custom_button.dart';
import '../../../res/components/tab_bar_setting.dart';
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
          child:Column(
            children: [
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
              SizedBox(height: 15,),
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    isScrollable: true,
                    labelPadding:
                    EdgeInsets.only(right: 20,left: 20),
                    indicator: CircleTabIndicator(color: AppColors.primaryIconColor,radius: 4),
                    controller: controller.tabController,
                    labelColor: AppColors.lightGrayColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        text: 'UploadFile',
                      ),
                      Tab(
                        text: 'UploadedFiles',
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(height: 598,
              width: double.infinity,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        customTextField(hintText: 'Name', controller: controller.state.nameController,
                        suffixIcon: Icons.drive_file_rename_outline,
                        ),
                        SizedBox(height: 10,),
                        GetBuilder<addFileController>(
                            builder: (con) {
                              return customTextField(
                                keyboardType: TextInputType.datetime,
                                controller:con.state.dateController,
                                hintText: DateFormat.yMMMd()
                                    .format(con.state.selectedDate),
                                suffixIcon: Icons.calendar_today_outlined,
                                onPressSufix: (){
                                  con.getDateFromUser(context);
                                },
                              );
                            }
                        ),
                        SizedBox(height:10,),
                        customTextField(hintText: 'File No', controller: controller.state.filenoController,
                        suffixIcon:Icons.format_list_numbered,
                        ),
                        SizedBox(height: 10,),
                        customTextField(hintText: 'From', controller: controller.state.fromController,
                        suffixIcon: Icons.person,
                        ),
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
                    Center(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: controller.state.ref.snapshots(),
                          builder:(BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
                            if(snapshot.hasData){
                              return snapshot.data!.docs.length !=0?
                                  ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder:(context,index){
                                    return Card(
                                      child: Padding(padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.docs[index]['Name'].toString()),
                                          SizedBox(height: 15,),
                                          SizedBox(height: 20,),
                                          Text(snapshot.data!.docs[index]['From'].toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          Text(snapshot.data!.docs[index]['Date'].toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      ),
                                    );
                                  }):Container();
                            }
                            else if (snapshot.hasError){
                              return CircularProgressIndicator();
                            }
                            else {
                              return Container();
                            }
                          }),
                    ),
                    // Center(
                    //   child:Container(
                    //       height: 200,
                    //       width: 200,
                    //       child: Icon(Icons.upload_file)) ,
                    // )
                    
                  ],
                ),
              )
            ],
          ) ,
          ),
        ),
      ),
    );
  }
}
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
        fontSize: 16.0,
        color: Colors.black,
      ),
      decoration: InputDecoration(

        labelText: lableText,
        labelStyle: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.bold),
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          onPressed: onPressSufix,
          icon: Icon(suffixIcon,color: Colors.grey,),
        ),
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
      keyboardType: keyboardType,
    );
  }
}
