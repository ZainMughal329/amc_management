import 'dart:io';
import 'package:amc_management/view/home/addFile/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../model/addFile_model/addFile_model.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/custom_button.dart';
import 'addFileCustomField.dart';class addFileForm extends GetView<addFileController> {
  const addFileForm({super.key});
  Widget dropDownList(){
    return Obx(()=> Expanded(
      flex: 0,
      child: DropdownButton(
        iconEnabledColor: AppColors.lightActiveIconColor,
        dropdownColor: AppColors.lightBgColor,
        style: TextStyle(color: AppColors.lightActiveIconColor),
        iconSize: 40.0.h,
        hint: controller.state.deptName.value==""?
        Text("selectDept",
          style: TextStyle(color: AppColors.titleTextColor),
        ):Text(
          controller.state.deptName.value,
          style: TextStyle(color: AppColors.subtitleTextColor),
        ),
        // value: controller.state.deptName.value,
        onChanged: (String? value){
          controller.state.deptName.value = value!;
        },
        items: [
          DropdownMenuItem(
            value: 'Principle',
            child: Text('Principle'),
          ),
          DropdownMenuItem(
            value: 'IT',
            child: Text('IT'),
          ),
          DropdownMenuItem(
            value: 'English',
            child: Text('English'),
          ),
          DropdownMenuItem(
            value: 'Math',
            child: Text('Math'),
          ),
          DropdownMenuItem(
            value: 'Physics',
            child: Text('Physics'),
          ),
          DropdownMenuItem(
            value: 'Economics',
            child: Text('Economics'),
          ),
          DropdownMenuItem(
            value: 'Biology',
            child: Text('Biology'),
          ),
          DropdownMenuItem(
            value: 'Urdu',
            child: Text('Urdu'),
          ),
          DropdownMenuItem(
            value: 'Chemistry',
            child: Text('Chemistry'),
          ),
        ],
      ),
    ));
  }
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
                  height: 200.h,
                  width: 200.w,

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
        SizedBox(height: 15.h,),
        customTextField(hintText: 'Name', controller: controller.state.nameController,
          suffixIcon: Icons.drive_file_rename_outline,
        ),
        SizedBox(height: 10.h,),
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
        SizedBox(height:10.h,),
        customTextField(hintText: 'File No', controller: controller.state.filenoController,
          suffixIcon:Icons.format_list_numbered,
        ),
        SizedBox(height: 10.h,),
        customTextField(hintText: 'From', controller: controller.state.fromController,
          suffixIcon: Icons.person,
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Dept'),
            dropDownList()
          ],
        ),
        ReuseButton(tittle: 'Upload', onpress: (){

          final addFile = AddFileModel(name: controller.state.nameController.text.trim(),
              dept: controller.state.deptName.toString().trim(),
              date: controller.state.dateController.text.trim(),
              from: controller.state.fromController.text.trim(),
              filenum: controller.state.filenoController.text.trim(),
              image: controller.imagePath.toString(),
            // id: DateTime.now().toString()
          );
          controller.storeData(addFile, context, controller.state.nameController.text.trim(),
              controller.state.fromController.text.trim(),
            controller.state.deptName.toString().trim(),
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
