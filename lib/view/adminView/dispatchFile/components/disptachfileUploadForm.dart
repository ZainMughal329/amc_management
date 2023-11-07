import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/custom_addordispatchfields.dart';
import '../../../../res/components/adminViewComponents/custom_button.dart';
import '../../../../res/components/adminViewComponents/detailTextForm.dart';
import '../../../../utils/custom_Utils.dart';
import '../index.dart';
import 'listOfImages/listofimages.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     GetBuilder<dispatchController>(builder:(controller){
                //       return InkWell(
                //         onTap: (){
                //           controller.pickImage(context);
                //         },
                //         child: Container(
                //             height: 200.h,
                //             width: double.infinity,
                //             decoration: BoxDecoration(
                //               color: controller.image == null
                //                   ? AppColors.unActiveTabElementColor
                //                   : AppColors.lightActiveIconColor,
                //               border: Border.all(
                //                 color: controller.image == null
                //                     ? AppColors.errorColor
                //                     : Colors.transparent,
                //                 // width: 3.0,
                //               ),
                //             ),
                //             child:Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [Column(
                //                 children: [
                //                   ClipRRect(
                //                     // borderRadius: BorderRadius.circular(100.r),
                //                     child: controller.image == null
                //                         ? Icon(
                //                       Icons.image,
                //                       size: 50.sp,
                //                       color: AppColors.lightActiveIconColor,
                //                     )
                //                         : Container(
                //                       height: 185.h,
                //                       width: double.infinity,
                //                       child: Image.file(
                //                         File(controller.image!.path)
                //                             .absolute,
                //                         fit: BoxFit.fill,
                //                       ),
                //                     ),
                //                   ),
                //                   controller.image == null
                //                       ? SizedBox(
                //                     height: 10.h,
                //                   )
                //                       : SizedBox(),
                //                   controller.image == null
                //                       ? Text(
                //                     "Tap to Upload Image",
                //                     style: TextStyle(
                //                         color: AppColors.subtitleTextColor),
                //                   )
                //                       : Container(),
                //                 ],
                //
                //               )],
                //
                //             )
                //         ),
                //       );
                //
                //     }),
                //   ],
                // ),
                SizedBox(
                  height: 15.h,
                ),
                customTextField(
                  focusNode: controller.state.nameFocusNode,
                  controller: controller.state.nameController,
                  lableText: 'FileName',
                  prefixIcon: Icon(Icons.drive_file_rename_outline),
                    onFiledSubmittedValue: (value){
                      ReuseableUtils.fieldfocous(context,
                          controller.state.nameFocusNode,
                          controller.state.dateFocusNode);
                    },
                    onvalidator: (value) {
                      return value.isEmpty ? 'Please Enter Name.' : null;
                    }
                ),
                SizedBox(
                  height: 10.h,
                ),
                GetBuilder<dispatchController>(
                    builder: (con) {
                      return customTextField(
                        keyboardType: TextInputType.datetime,
                        focusNode:controller.state.dateFocusNode,
                        controller:con.state.dateController,
                        hintText: DateFormat.yMMMd()
                            .format(con.state.selectedDate),
                        suffixIcon: Icons.calendar_today_outlined,
                        onPressSufix: (){
                          con.getDateFromUser(context);
                        },
                          onFiledSubmittedValue: (value){
                            ReuseableUtils.fieldfocous(context,
                                controller.state.dateFocusNode,
                                controller.state.recievedByFocusNode);
                          },
                          prefixIcon: Icon(Icons.date_range_outlined),

                          onvalidator: (value) {
                            return value.isEmpty ? 'Please Enter Date.' : null;
                          }
                      );
                    }
                ),
                SizedBox(
                  height: 10.h,
                ),
                customTextField(
                  focusNode: controller.state.recievedByFocusNode,
                  controller: controller.state.recievedByController,
                  lableText: 'recievedBy',
                  prefixIcon: Icon(Icons.person),
                    onFiledSubmittedValue: (value){
                      ReuseableUtils.fieldfocous(context,
                          controller.state.recievedByFocusNode,
                          controller.state.notificationToFocusNode);
                    },
                    onvalidator: (value) {
                      return value.isEmpty ? 'Please Enter Receiver Name.' : null;
                    }
                ),
                SizedBox(
                  height: 10.h,
                ),
                customTextField(
                  focusNode: controller.state.notificationToFocusNode,
                  lableText: 'notificationTo',
                  controller:
                  controller.state.notificationToController,
                  prefixIcon: Icon(Icons.person),
                  onFiledSubmittedValue: (value){
                    ReuseableUtils.fieldfocous(context,
                        controller.state.notificationToFocusNode,
                        controller.state.filenumFocousNode);
                  },
                    onvalidator: (value) {
                      return value.isEmpty ? 'Please Enter  Name.' : null;
                    }
                ),
                SizedBox(height: 10.h,),
                customTextField(
                  controller: controller.state.fileNumcontroller,
                  focusNode: controller.state.filenumFocousNode,
                  hintText: 'Enter File Number',
                  onFiledSubmittedValue: (value){
                    ReuseableUtils.fieldfocous(context,
                        controller.state.filenumFocousNode,
                        controller.state.detailFocousNode);

                  },
                    onvalidator: (value) {
                      return value.isEmpty ? 'Please Enter File Number.' : null;
                    }
                ),
                SizedBox(
                  height: 10.h,
                ),
                detailTextFormField(
                  controller: controller.state.detailController,
                  focusNode: controller.state.detailFocousNode,
                  hintText: 'Please Enter File Details',
                  onFiledSubmittedValue: (value){

                  },
                  onvalidator: (value) {
                    return value.isEmpty ? 'Please Enter File Detail.' : null;
                  },
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Dept'),
                    dropDownList()
                  ],
                ),
                ReuseButton(
                    tittle: 'Select Images',
                    loading: controller.state.loading.value,
                    onpress: () {
                      String docId = DateTime.now().millisecondsSinceEpoch.toString();
                      controller.dispatchfileDataOnFirebase(
                        controller.state.fileNumcontroller.text.trim(),
                          controller.documentId,
                          controller.state.nameController.text.trim(),
                          controller.state.dateController.text.trim(),
                          controller.state.recievedByController.text.trim(),
                          controller.state.deptName.value,
                          controller.state.notificationToController.text.trim(),
                          controller.state.detailController.text.trim());
                      Get.to(() => listOfImages(
                        fileNum: controller.state.fileNumcontroller.text.trim(),
                          FileName: controller.state.nameController.text.trim(),
                          date: controller.state.dateController.text.trim(),
                          recievedBy:controller.state.recievedByController.text.trim(),
                          notificationTo: controller.state.notificationToController.text.trim(),
                          details: controller.state.detailController.text.trim(),
                          deptName: controller.state.deptName.value));
                    }),
              ],
            ),
          ),
        ),
      ),
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
