import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/sharedComponents/custom_addordispatchfields.dart';
import '../../../../res/components/adminViewComponents/custom_button.dart';
import '../../../../res/components/adminViewComponents/sharedComponents/detailTextForm.dart';
import '../../../../utils/custom_Utils.dart';
import '../index.dart';
import 'listOfImages/listofimages.dart';

class dispatchFileForm extends GetView<dispatchController> {
  dispatchFileForm({super.key});

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
                value: 'Vice-Principle',
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
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    height: 20.h,
                  ),
                  customTextField(
                      controller: controller.state.serialNumcontroller,
                      focusNode: controller.state.serialnumFocousNode,
                      hintText: 'Enter Serial Number',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icon(Icons.numbers_outlined),
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.serialnumFocousNode,
                            controller.state.letterNumFocusNode);
                      },
                      onvalidator: (value) {
                        return value.isEmpty ? 'Please Enter Serial Number.' : null;
                      }),

                  SizedBox(
                    height: 10.h,
                  ),
                  customTextField(
                      focusNode: controller.state.letterNumFocusNode,
                      lableText: 'Letter Num',
                      keyboardType: TextInputType.number,
                      controller: controller.state.letterNumController,
                      prefixIcon: Icon(Icons.numbers_outlined),
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.letterNumFocusNode,
                            controller.state.dateFocusNode);
                      },
                      onvalidator: (value) {
                        return value.isEmpty ? 'Please Enter  Letter Num.' : null;
                      }),
                  SizedBox(
                    height: 10.h,
                  ),
                  GetBuilder<dispatchController>(builder: (con) {
                    return customTextField(
                        keyboardType: TextInputType.datetime,
                        focusNode: controller.state.dateFocusNode,
                        controller: con.state.dateController,
                        hintText: con.state.selectedDate != null
                            ? DateFormat.yMMMd().format(con.state.selectedDate)
                            : "Select a date",
                        suffixIcon: Icons.calendar_today_outlined,
                        onPressSufix: () {
                          con.getDateFromUser(context);
                        },
                        onFiledSubmittedValue: (value) {
                          ReuseableUtils.fieldfocous(
                              context,
                              controller.state.dateFocusNode,
                              controller.state.receiverNameFocousNode);
                        },
                        prefixIcon: Icon(Icons.date_range_outlined),
                        onvalidator: (value) {
                          return value.isEmpty ? 'Please Enter Date.' : null;
                        });
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  customTextField(
                      focusNode: controller.state.receiverNameFocousNode,
                      controller: controller.state.receiverNameController,
                      lableText: 'recieverName',
                      prefixIcon: Icon(Icons.person),
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.receiverNameFocousNode,
                            controller.state.receiverAddressFocousNode);
                      },
                      onvalidator: (value) {
                        return value.isEmpty
                            ? 'Please Enter Receiver Name.'
                            : null;
                      }),
                  detailTextFormField(
                    controller: controller.state.receiverAddressController,
                    focusNode: controller.state.receiverAddressFocousNode,
                    hintText: 'Please Enter Receiver Address',
                    onFiledSubmittedValue: (value) {
                      ReuseableUtils.fieldfocous(context,
                          controller.state.receiverAddressFocousNode,
                         controller.state.subjectFocousNode
                      );
                    },
                    onvalidator: (value) {
                      return value.isEmpty ? 'Please Enter Receiver Address.' : null;
                    },
                  ),
                  SizedBox(height: 10.h,),

                  detailTextFormField(
                    controller: controller.state.subjectController,
                    focusNode: controller.state.subjectFocousNode,
                    hintText: 'Please Enter Subject of file',
                    onFiledSubmittedValue: (value)
                    {},
                    onvalidator: (value) {
                      return value.isEmpty ? 'Please Enter Subject of File.' : null;
                    },
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Select Dept'), dropDownList()],
                  ),
                  SizedBox(height: 10.h,),
                  Obx(
                    () => controller.state.loading.value == true
                        ?  Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColour,
                      ),
                    )
                        :ReuseButton(
                        tittle: 'Select Images',
                        // loading: controller.state.loading.value,
                        onpress: () {
                          String docId = DateTime.now()
                              .millisecondsSinceEpoch
                              .toString();
                          controller.dispatchfileDataOnFirebase(controller.documentId,
                              controller.state.subjectController.text.trim(),
                              controller.state.deptName.value.trim(),
                              controller.state.letterNumController.text.trim(),
                              controller.state.serialNumcontroller.text.trim(),
                              controller.state.receiverNameController.text.trim(),
                              controller.state.receiverAddressController.text.trim(),
                              controller.state.selectedDate);
                        }),
                  ),
                ],
              ),
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
