

import 'dart:io';
import 'package:amc_management/view/home/dispatchFile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../model/dispatch_model/dispatch_model.dart';
import '../../../../res/components/custom_button.dart';
import '../../addFile/components/addFileCustomField.dart';
class dispatchFileForm extends GetView<dispatchController> {
   dispatchFileForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
                  () => Container(
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
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: controller.imagePath.isNotEmpty?FileImage(File(controller.imagePath.toString())))
                  // ),
                  child: controller.imagePath == ''
                      ? Icon(Icons.file_copy)
                      : Image(
                      fit: BoxFit.cover,
                      image: FileImage(File(controller
                          .imagePath
                          .toString())))),
            ),
            controller.imagePath == ''
                ? Center(
              child: TextButton(
                  onPressed: () {
                    controller.pickImage(context);
                  },
                  child: Text('Pick Image')),
            )
                : Container()
          ],
        ),
        SizedBox(
          height: 20,
        ),
        customTextField(
          lableText: 'FileName',
          hintText: 'Name',
          controller: controller.state.nameController,
          suffixIcon: Icons.drive_file_rename_outline,
        ),
        SizedBox(
          height: 10,
        ),
        GetBuilder<dispatchController>(
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
        SizedBox(
          height: 10,
        ),
        customTextField(
          hintText: 'recievedBy',
          controller:
          controller.state.recievedByController,
          suffixIcon: Icons.person,
        ),
        SizedBox(
          height: 10,
        ),
        customTextField(
          hintText: 'notificationTo',
          controller:
          controller.state.notificationToController,
          suffixIcon: Icons.person,
        ),
        SizedBox(
          height: 20,
        ),
        // Obx(() => TextFormField(
        //   controller: controller.state.markByController,
        //   decoration: InputDecoration(
        //     labelText: 'Choose an option',
        //     suffixIcon: DropdownButton<String>(
        //       hint: Text(controller.state.deptName.value.toString()),
        //       value: controller.state.deptName.value,
        //       onChanged: (String? newValue){
        //         if(newValue != null){
        //           controller.state.deptName.value = newValue;
        //         }
        //       },
        //       items:  [
        //         DropdownMenuItem(
        //           value: 'principle',
        //           child: Text('Principle'),
        //         ),
        //         DropdownMenuItem(
        //           value: 'IT',
        //           child: Text('IT'),
        //         ),
        //         DropdownMenuItem(
        //           value: 'english',
        //           child: Text('English'),
        //         ),
        //         DropdownMenuItem(
        //           value: 'math',
        //           child: Text('Math'),
        //         ),
        //         DropdownMenuItem(
        //           value: 'physics',
        //           child: Text('Physics'),
        //         ),
        //         DropdownMenuItem(
        //           value: 'economics',
        //           child: Text('Economics'),
        //         ),
        //         DropdownMenuItem(
        //           value: 'biology',
        //           child: Text('Biology'),
        //         ),
        //         DropdownMenuItem(
        //           value: 'urdu',
        //           child: Text('Urdu'),
        //         ),
        //         DropdownMenuItem(
        //           value: 'chemistry',
        //           child: Text('Chemistry'),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Dept'),
            Flexible(
              child: Obx((){
                return DropdownButton(
                  hint: Text(controller.state.deptName.value.toString()),
                  value: controller.state.deptName.value,
                  onChanged: (String? newValue){
                    if(newValue != null){
                      controller.state.deptName.value = newValue;
                    }
                  },
                  items:<DropdownMenuItem<String>> [
                    DropdownMenuItem<String>(
                      value: 'Principle',
                      child: Text('Principle'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'IT',
                      child: Text('IT'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'English',
                      child: Text('English'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Math',
                      child: Text('Math'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Physics',
                      child: Text('Physics'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Economics',
                      child: Text('Economics'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Biology',
                      child: Text('Biology'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Urdu',
                      child: Text('Urdu'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Chemistry',
                      child: Text('Chemistry'),
                    ),
                  ],
                );
              }),
            )
          ],
        ),

        ReuseButton(
            tittle: 'Dispatch',
            onpress: () {
              final dispatch = DispatchModel(
                  name: controller.state.nameController.text
                      .trim(),
                  date: controller.state.selectedDate
                      .toString()
                      .trim(),
                  recievedBy: controller
                      .state.recievedByController.text
                      .trim(),
                  notificationTo: controller
                      .state.notificationToController.text
                      .trim(),
                  image: controller.imagePath.toString());
              controller.storeData(
                dispatch,
                context,
                controller.imagePath.value.toString(),
                controller.state.nameController.text.trim(),
                controller.state.recievedByController.text
                    .trim(),
                controller.state.notificationToController.text
                    .trim(),
                controller.state.selectedDate
                    .toString()
                    .trim(),
              );
            })
      ],
    );
  }
}
