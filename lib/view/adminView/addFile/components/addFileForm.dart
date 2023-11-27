import 'dart:io';
import 'package:amc_management/res/components/adminViewComponents/box_button.dart';
import 'package:amc_management/utils/custom_Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../model/addFile_model/addFile_model.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/custom_addordispatchfields.dart';
import '../../../../res/components/adminViewComponents/custom_button.dart';
import '../../../../res/components/adminViewComponents/detailTextForm.dart';
import '../index.dart';
import 'listofImages/view.dart';

class addFileForm extends GetView<addFileController> {
  addFileForm({super.key});
  Widget dropDownList() {
    return Obx(() => Expanded(
          flex: 0,
          child: DropdownButton(
            iconEnabledColor: AppColors.lightActiveIconColor,
            dropdownColor: AppColors.lightBgColor,
            style: TextStyle(color: AppColors.lightActiveIconColor),
            iconSize: 40.0.h,
            hint: controller.state.deptName.value == ""
                ? Text(
                    "selectDept",
                    style: TextStyle(color: AppColors.titleTextColor),
                  )
                : Text(
                    controller.state.deptName.value,
                    style: TextStyle(color: AppColors.subtitleTextColor),
                  ),
            // value: controller.state.deptName.value,
            onChanged: (String? value) {
              controller.state.deptName.value = value!;
            },
            items: [
              DropdownMenuItem(
                value: 'Principle',
                child: Text('Principle'),
              ),
              DropdownMenuItem(
                value: 'Vice_Principle',
                child: Text('Vice_Principle'),
              ),
              DropdownMenuItem(
                value: 'Staff',
                child: Text('Staff'),
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
      backgroundColor: AppColors.scaffoldBgColour,
      resizeToAvoidBottomInset: true,
      body: GetBuilder<addFileController>(
        init: addFileController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Form(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       // GetBuilder<addFileController>(builder: (controller) {
                    //       //   return InkWell(
                    //       //     onTap: () {
                    //       //       controller.pickImage(context);
                    //       //     },
                    //       //     child: Container(
                    //       //         height: 200.h,
                    //       //         width: double.infinity,
                    //       //         decoration: BoxDecoration(
                    //       //           color: controller.image == null
                    //       //               ? AppColors.unActiveTabElementColor
                    //       //               : AppColors.lightActiveIconColor,
                    //       //           border: Border.all(
                    //       //             color: controller.image == null
                    //       //                 ? AppColors.textColour
                    //       //                 : Colors.transparent,
                    //       //             // width: 3.0,
                    //       //           ),
                    //       //         ),
                    //       //         child: Column(
                    //       //           mainAxisAlignment: MainAxisAlignment.center,
                    //       //           children: [
                    //       //             Column(
                    //       //               children: [
                    //       //                 ClipRRect(
                    //       //                   child: controller.image == null
                    //       //                       ? Icon(
                    //       //                           Icons.image,
                    //       //                           size: 50.sp,
                    //       //                           color:
                    //       //                               AppColors.lightActiveIconColor,
                    //       //                         )
                    //       //                       : Container(
                    //       //                           height: 185.h,
                    //       //                           width: double.infinity,
                    //       //                           child: Image.file(
                    //       //                             File(controller.image!.path)
                    //       //                                 .absolute,
                    //       //                             fit: BoxFit.fill,
                    //       //                           ),
                    //       //                         ),
                    //       //                 ),
                    //       //                 controller.image == null
                    //       //                     ? SizedBox(
                    //       //                         height: 10.h,
                    //       //                       )
                    //       //                     : SizedBox(),
                    //       //                 controller.image == null
                    //       //                     ? Text(
                    //       //                         "Tap to Upload Image",
                    //       //                         style: TextStyle(
                    //       //                             color:
                    //       //                                 AppColors.subtitleTextColor),
                    //       //                       )
                    //       //                     : Container(),
                    //       //               ],
                    //       //             )
                    //       //           ],
                    //       //         )),
                    //       //   );
                    //       // })
                    //       InkWell(
                    //           onTap: (){
                    //             Get.to(ListOfFileView(
                    //               details: controller.state.detailController.text.trim(),
                    //               date: controller.state.dateController.text.trim(),
                    //               fileNo: controller.state.filenoController.text.trim(),
                    //               recieverName: controller.state.fromController.text.trim(),
                    //               FileName: controller.state.nameController.text.trim(),
                    //               deptName:controller.state.deptName.value,
                    //             ));
                    //           },
                    //           child: Container(
                    //               decoration: BoxDecoration(
                    //                   border: Border.all(
                    //                       color: AppColors.elevatedButtonColour
                    //                   )
                    //               ),
                    //               height: 150.h,
                    //               width: double.infinity,
                    //               child: Center(child: Text('Tap To Upload a photo')))
                    //
                    //       )]
                    // ),
                    SizedBox(
                      height: 15.h,
                    ),
                    customTextField(
                        focusNode: controller.state.nameFocusNode,
                        controller: controller.state.nameController,
                        lableText: 'Name',
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        onFiledSubmittedValue: (value) {
                          ReuseableUtils.fieldfocous(
                              context,
                              controller.state.nameFocusNode,
                              controller.state.dateFocusNode);
                        },
                        onvalidator: (value) {
                          return value.isEmpty ? 'Please Enter Name.' : null;
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    GetBuilder<addFileController>(builder: (con) {
                      return customTextField(
                          keyboardType: TextInputType.datetime,
                          focusNode: controller.state.dateFocusNode,
                          controller: con.state.dateController,
                          prefixIcon: Icon(Icons.date_range_outlined),
                          hintText:con.state.selectedDate !=null?
                              DateFormat.yMMMd().format(con.state.selectedDate):
                              "Select a date",
                          suffixIcon: Icons.calendar_today_outlined,
                          onPressSufix: () {
                            con.getDateFromUser(context);
                          },
                          onFiledSubmittedValue: (value) {
                            ReuseableUtils.fieldfocous(
                                context,
                                controller.state.dateFocusNode,
                                controller.state.filenoFocusNode);
                          },
                          onvalidator: (value) {
                            return value.isEmpty ? 'Please Enter Date.' : null;
                          });
                    }),
                    SizedBox(
                      height: 10.h,
                    ),
                    customTextField(
                        keyboardType: TextInputType.number,
                        lableText: 'File No',
                        controller: controller.state.filenoController,
                        focusNode: controller.state.filenoFocusNode,
                        prefixIcon: Icon(Icons.format_list_numbered),
                        onFiledSubmittedValue: (value) {
                          ReuseableUtils.fieldfocous(
                              context,
                              controller.state.filenoFocusNode,
                              controller.state.fromFocusNode);
                        },
                        onvalidator: (value) {
                          return value.isEmpty
                              ? 'Please Enter File Number.'
                              : null;
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    customTextField(
                      lableText: 'From',
                      focusNode: controller.state.fromFocusNode,
                      controller: controller.state.fromController,
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.fromFocusNode,
                            controller.state.detailFocusNode);
                      },
                      onvalidator: (value) {
                        return value.isEmpty
                            ? 'Please Enter Receiver Name.'
                            : null;
                      },
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    detailTextFormField(
                      controller: controller.state.detailController,
                      focusNode: controller.state.detailFocusNode,
                      hintText: 'Please Enter File Details',
                      onFiledSubmittedValue: (value) {},
                      onvalidator: (value) {
                        return value.isEmpty
                            ? 'Please Enter File Detail.'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Select Dept'), dropDownList()],
                    ),
                    SizedBox(height: 15.h,),

                    // if(controller.state.isFormValid.value)
                    Obx(() => controller.state.loading.value == false ? ReuseButton(
                        tittle: 'Select Images',
                        loading: controller.state.loading.value,
                        onpress: () {
                          String docId = DateTime.now().millisecondsSinceEpoch.toString();

                          controller.addFileDataOnFirebase(
                            controller.documentId,
                            controller.state.nameController.text
                              .trim(), controller.state.selectedDate,
                            controller.state.filenoController.text
                              .trim(), controller.state.deptName.value
                              .trim(), controller.state.fromController.text
                              .trim(), controller.state.detailController.text
                              .trim(),);
                        }) : Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColour,
                      ),
                    ),),
                    // (controller.state.isFormValid.value)?

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



