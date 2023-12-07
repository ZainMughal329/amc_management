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
import 'controller.dart';

class receivedFileForm extends GetView<dataUplaodController> {
  receivedFileForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.filesBgColour,
      resizeToAvoidBottomInset: true,
      body: GetBuilder<dataUplaodController>(
        init: dataUplaodController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
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
                      GetBuilder<dataUplaodController>(builder: (con) {
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

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [Text('Select Dept'), dropDownList()],
                      // ),
                      SizedBox(height: 30.h,),

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
                              // controller.state.deptName.value.trim(),
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
            ),
          );
        },
      ),
    );
  }
}
