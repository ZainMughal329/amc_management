import 'dart:io';
import 'package:amc_management/view/home/dispatchFile/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../model/dispatch_model/dispatch_model.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/custom_button.dart';
import '../../addFile/components/addFileCustomField.dart';
class dispatchFileForm extends GetView<dispatchController> {
   dispatchFileForm({super.key});
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<dispatchController>(builder:(controller){
              return InkWell(
                onTap: (){
                  controller.pickImage(context);
                },
                child: Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: controller.image == null
                          ? AppColors.unActiveTabElementColor
                          : AppColors.lightActiveIconColor,
                      border: Border.all(
                        color: controller.image == null
                            ? AppColors.errorColor
                            : Colors.transparent,
                        // width: 3.0,
                      ),
                    ),
                    //  controller.imagePath == ''
                    //                       ? Icon(Icons.file_copy)
                    //                       : Image(
                    //                       fit: BoxFit.cover,
                    //                       image: FileImage(File(controller
                    //                           .imagePath
                    //                           .toString())))

                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Column(
                        children: [
                          ClipRRect(
                            // borderRadius: BorderRadius.circular(100.r),

                            child: controller.image == null
                                ? Icon(
                              Icons.image,
                              size: 50.sp,
                              color: AppColors.lightActiveIconColor,
                            )
                                : Container(
                              height: 185.h,
                              width: double.infinity,
                              child: Image.file(
                                File(controller.image!.path)
                                    .absolute,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          controller.image == null
                              ? SizedBox(
                            height: 10.h,
                          )
                              : SizedBox(),
                          controller.image == null
                              ? Text(
                            "Tap to Upload Image",
                            style: TextStyle(
                                color: AppColors.subtitleTextColor),
                          )
                              : Container(),
                        ],

                      )],

                    )
                ),
              );

            }),

            // controller.imagePath == ''
            //     ? Center(
            //   child: TextButton(
            //       onPressed: () {
            //         controller.pickImage(context);
            //       },
            //       child: Text('Pick Image')),
            // )
            //     : Container()
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        customTextField(
          lableText: 'FileName',
          hintText: 'Name',
          controller: controller.state.nameController,
          suffixIcon: Icons.drive_file_rename_outline,
        ),
        SizedBox(
          height: 10.h,
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
          height: 10.h,
        ),
        customTextField(
          hintText: 'recievedBy',
          controller:
          controller.state.recievedByController,
          suffixIcon: Icons.person,
        ),
        SizedBox(
          height: 10.h,
        ),
        customTextField(
          hintText: 'notificationTo',
          controller:
          controller.state.notificationToController,
          suffixIcon: Icons.person,
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Dept'),
            dropDownList()
          ],
        ),
        ReuseButton(
            tittle: 'Dispatch',
            onpress: () {
              final dispatch = DispatchModel(
                  name: controller.state.nameController.text
                      .trim(),
                  dept: controller.state.deptName.toString().trim(),
                  date: controller.state.selectedDate
                      .toString()
                      .trim(),
                  recievedBy: controller
                      .state.recievedByController.text
                      .trim(),
                  notificationTo: controller
                      .state.notificationToController.text
                      .trim(),
                  image: controller.image!.path.toString());
              controller.storeData(
                dispatch,
                context,
                controller.image!.path.toString(),
                controller.state.nameController.text.trim(),
                controller.state.recievedByController.text
                    .trim(),
                controller.state.deptName.toString().trim(),
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

// void _showCustomDialog(
//     BuildContext context, DispatchModel controller) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Choose an Option'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               leading: Icon(Icons.camera),
//               title: Text('Camera'),
//               onTap: () {
//                 Navigator.pop(context);
//                 print("insdie camera code");
//                 controller.pickedImageFromCamera(context);
//
//                 // Handle Camera onTap
//                 // _handleCameraTap(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo_library),
//               title: Text('Gallery'),
//               onTap: () {
//                 Navigator.pop(context);
//                 controller.pickedImageFromGallery(context);
//                 // Handle Gallery onTap
//                 // _handleGalleryTap(context);
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
//
