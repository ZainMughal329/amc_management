import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_button.dart';
import 'package:amc_management/res/components/adminViewComponents/sharedComponents/custom_addordispatchfields.dart';
import 'package:amc_management/res/components/adminViewComponents/sharedComponents/detailTextForm.dart';
import 'package:amc_management/utils/custom_Utils.dart';
import 'package:amc_management/view/adminView/diaryNumRegister/dataUplaodForm/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../listOfImages/controller.dart';

class diaryNumberForm extends GetView<dataUplaodController> {
   diaryNumberForm({super.key});
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
  final con = Get.put<listOfImagesController>(listOfImagesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColour,
      resizeToAvoidBottomInset: true,
      body: GetBuilder<dataUplaodController>(
        init: dataUplaodController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Form(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      customTextField(
                        keyboardType: TextInputType.number,
                        lableText: 'Serial Num',
                        controller: controller.state.serialNumController,
                        focusNode: controller.state.serialNumFocus,
                        prefixIcon: Icon(Icons.format_list_numbered),
                        onFiledSubmittedValue: (value) {
                          ReuseableUtils.fieldfocous(
                              context,
                              controller.state.serialNumFocus,
                              controller.state.dateFocus);
                        },
                        onvalidator: (value) {
                          return value.isEmpty
                              ? 'Please Enter Serial Number.'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GetBuilder<dataUplaodController>(builder: (controller) {
                        return customTextField(
                            keyboardType: TextInputType.datetime,
                            focusNode: controller.state.dateFocus,
                            controller: controller.state.dateController,
                            prefixIcon: Icon(Icons.date_range_outlined),
                            hintText: controller.state.selectedDate != null
                                ? DateFormat.yMMMd()
                                    .format(controller.state.selectedDate)
                                : "Select a date",
                            suffixIcon: Icons.calendar_today_outlined,
                            onPressSufix: () {
                              controller.getDateFromUser(context);
                            },
                            onFiledSubmittedValue: (value) {
                              ReuseableUtils.fieldfocous(
                                  context,
                                  controller.state.dateFocus,
                                  controller.state.fileDispatchDateFocus);
                            },
                            onvalidator: (value) {
                              return value.isEmpty
                                  ? 'Please Enter Date.'
                                  : null;
                            });
                      }),
                      SizedBox(
                        height: 10.h,
                      ),
                      GetBuilder<dataUplaodController>(builder: (controller) {
                        return customTextField(
                            keyboardType: TextInputType.datetime,
                            focusNode: controller.state.fileDispatchDateFocus,
                            controller:
                                controller.state.fileDispatchDateController,
                            prefixIcon: Icon(Icons.date_range_outlined),
                            hintText: controller.state.dispatchSelDate != null
                                ? DateFormat.yMMMd()
                                    .format(controller.state.dispatchSelDate)
                                : "Select a date",
                            suffixIcon: Icons.calendar_today_outlined,
                            onPressSufix: () {
                              controller.getDispatchDateFromUser(context);
                            },
                            onFiledSubmittedValue: (value) {
                              ReuseableUtils.fieldfocous(
                                  context,
                                  controller.state.fileDispatchDateFocus,
                                  controller.state.senderNameFocus);
                            },
                            onvalidator: (value) {
                              return value.isEmpty
                                  ? 'Please Enter File Dispatch Date.'
                                  : null;
                            });
                      }),
                      SizedBox(
                        height: 10.h,
                      ),
                      customTextField(
                        keyboardType: TextInputType.text,
                        lableText: 'Sender Name',
                        controller: controller.state.senderNameController,
                        focusNode: controller.state.senderNameFocus,
                        prefixIcon: Icon(Icons.person_outlined),
                        onFiledSubmittedValue: (value) {
                          ReuseableUtils.fieldfocous(
                              context,
                              controller.state.senderNameFocus,
                              controller.state.receiverNameFocus);
                        },
                        onvalidator: (value) {
                          return value.isEmpty
                              ? 'Please Enter Sender Name.'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      customTextField(
                        keyboardType: TextInputType.text,
                        lableText: 'Receiver Name',
                        controller: controller.state.receiverNameController,
                        focusNode: controller.state.receiverNameFocus,
                        prefixIcon: Icon(Icons.person_outlined),
                        onFiledSubmittedValue: (value) {
                          ReuseableUtils.fieldfocous(
                              context,
                              controller.state.receiverNameFocus,
                              controller.state.senderAddressFocus);
                        },
                        onvalidator: (value) {
                          return value.isEmpty
                              ? 'Please Enter Receiver Name.'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      detailTextFormField(
                        controller: controller.state.senderAddressController,
                        focusNode: controller.state.senderAddressFocus,
                        keyboardType: TextInputType.text,
                        lableText: 'Enter Sender Address',
                        prefixIcon: Icon(Icons.house_outlined),
                        onFiledSubmittedValue: (value) {
                          ReuseableUtils.fieldfocous(
                              context,
                              controller.state.senderAddressFocus,
                              controller.state.fileSubjectFocus);
                        },
                        onvalidator: (value) {
                          return value.isEmpty
                              ? 'Please Enter Sender Address.'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      detailTextFormField(
                        controller: controller.state.fileSubjectController,
                        focusNode: controller.state.fileSubjectFocus,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(Icons.file_copy_sharp),
                        lableText: 'Enter Subject Of File',
                        onFiledSubmittedValue: (value) {
                          //   ReuseableUtils.fieldfocous(
                          //       context,
                          //       controller.state.senderAddressFocus,
                          //       controller.state.fileSubjectFocus);
                        },
                        onvalidator: (value) {
                          return value.isEmpty
                              ? 'Please Enter Subject Of File.'
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
                      SizedBox(height: 10.h,),
                      Obx(
                        () => controller.state.loading.value == false
                            ? ReuseButton(
                          loading: controller.state.loading.value,
                                tittle: 'Select Images', onpress: () {
                          String docId = DateTime.now().millisecondsSinceEpoch.toString();
                          controller.uploadDiaryNumberFiles(
                              controller.documentId,
                              controller.state.serialNumController.text.trim(),
                              controller.state.selectedDate,
                              controller.state.dispatchSelDate,
                              controller.state.senderNameController.text.trim(),
                              controller.state.receiverNameController.text.trim(),
                              controller.state.senderAddressController.text.trim(),
                              controller.state.deptName.value.trim(),
                              controller.state.fileSubjectController.text.trim());

                        })
                            : Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.buttonColour,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
