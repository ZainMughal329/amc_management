import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/adminViewComponents/sharedComponents/custom_addordispatchfields.dart';
import 'package:amc_management/res/components/adminViewComponents/sharedComponents/detailTextForm.dart';
import 'package:amc_management/utils/custom_Utils.dart';
import 'package:amc_management/view/adminView/diaryNumRegister/dataUplaodForm/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class diaryNumberForm extends GetView<dataUplaodController> {
  const diaryNumberForm({super.key});
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
                            return value.isEmpty ? 'Please Enter Date.' : null;
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
                                controller.state.fileDispatchDateFocus,
                                controller.state.senderNameFocus);
                          },
                          onvalidator: (value) {
                            return value.isEmpty
                                ? 'Please Enter File Dispatch Date.'
                                : null;
                          });
                    }),
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
                      lableText: 'Enter Sender Name',
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
