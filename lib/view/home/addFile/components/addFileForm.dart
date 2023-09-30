import 'dart:io';
import 'package:amc_management/view/home/addFile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../model/addFile_model/addFile_model.dart';
import '../../../../res/components/custom_button.dart';
import 'addFileCustomField.dart';
class addFileForm extends GetView<addFileController> {
  const addFileForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
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
              image: controller.imagePath.toString(),
            // id: DateTime.now().toString()
          );
          controller.storeData(addFile, context, controller.state.nameController.text.trim(),
              controller.state.fromController.text.trim(),
              controller.imagePath.toString(),
              controller.state.filenoController.text.trim(),
              controller.state.dateController.text.trim(),
            // controller.fileId.toString().trim(),
          );
        })
      ],
    );
  }
}
