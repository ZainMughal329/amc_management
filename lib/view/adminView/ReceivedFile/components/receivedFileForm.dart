import 'dart:io';
import 'package:amc_management/res/components/adminViewComponents/box_button.dart';
import 'package:amc_management/utils/custom_Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/sharedComponents/custom_addordispatchfields.dart';
import '../../../../res/components/adminViewComponents/custom_button.dart';
import '../../../../res/components/adminViewComponents/sharedComponents/detailTextForm.dart';
import '../index.dart';
import 'listofImages/view.dart';

class receivedFileForm extends GetView<receivedFileController> {
  receivedFileForm({super.key});
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
      body: GetBuilder<receivedFileController>(
        init: receivedFileController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Form(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    customTextField(
                        keyboardType: TextInputType.number,
                        lableText: 'Serial Num',
                        controller: controller.state.serialNumController,
                        focusNode: controller.state.serialNumFocusNode,
                        prefixIcon: Icon(Icons.format_list_numbered),
                        onFiledSubmittedValue: (value) {
                          ReuseableUtils.fieldfocous(
                              context,
                              controller.state.serialNumFocusNode,
                              controller.state.dateFocusNode);
                        },
                        onvalidator: (value) {
                          return value.isEmpty
                              ? 'Please Enter Serial Number.'
                              : null;
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    GetBuilder<receivedFileController>(builder: (con) {
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
                                controller.state.receivedFromFocusNode);
                          },
                          onvalidator: (value) {
                            return value.isEmpty ? 'Please Enter Date.' : null;
                          });
                    }),
                    SizedBox(
                      height: 10.h,
                    ),

                    customTextField(
                      lableText: 'Received From',
                      focusNode: controller.state.receivedFromFocusNode,
                      controller: controller.state.receivedfromController,
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.receivedFromFocusNode,
                            controller.state.receiverNameFocusNode);
                      },
                      onvalidator: (value) {
                        return value.isEmpty
                            ? 'Please Enter Received From Name.'
                            : null;
                      },
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    customTextField(
                      lableText: 'Receiver Name',
                      focusNode: controller.state.receiverNameFocusNode,
                      controller: controller.state.receiverNameController,
                      prefixIcon: Icon(Icons.person_outlined),
                      onFiledSubmittedValue: (value){
                        ReuseableUtils.fieldfocous(context,
                            controller.state.receiverNameFocusNode,
                            controller.state.receiverAddressFocusNode);
                      },
                      onvalidator: (value){
                        return value.isEmpty
                            ? 'Please Enter Receiver Name.'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    detailTextFormField(
                      controller: controller.state.receiverAddressController,
                      focusNode: controller.state.receiverAddressFocusNode,
                      lableText:'Please Enter Receiver Address' ,
                     prefixIcon: Icon(Icons.house_outlined),
                      onFiledSubmittedValue: (value) {},
                      onvalidator: (value) {
                        return value.isEmpty
                            ? 'Please Enter Receiver Address.'
                            : null;
                      },
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
                          controller.uploadReceivedFileDataOnFirebase(
                              controller.documentId,
                              controller.state.selectedDate,
                              controller.state.serialNumController.text.trim(),
                              controller.state.deptName.value.trim(),
                              controller.state.receiverNameController.text.trim(),
                              controller.state.receiverAddressController.text.trim(),
                            controller.state.receivedfromController.text
                                .trim(),
                          );
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
