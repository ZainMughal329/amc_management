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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.filesBgColour,
      resizeToAvoidBottomInset: true,
      // here i wrap the widget with getbuilder
      body: GetBuilder<dispatchController>(
        init: dispatchController(),
        builder: (controller){
          return SingleChildScrollView(
            child: Form(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                          lableText: 'receiverName',
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
                      SizedBox(height: 10.h,),

                      detailTextFormField(
                        controller: controller.state.receiverAddressController,
                        focusNode: controller.state.receiverAddressFocousNode,
                        lableText:'Please Enter Receiver Address' ,
                        prefixIcon: Icon(Icons.house_outlined),
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
                      SizedBox(height: 15.h,),

                      detailTextFormField(
                        controller: controller.state.subjectController,
                        focusNode: controller.state.subjectFocousNode,
                        prefixIcon: Icon(Icons.file_copy_sharp),
                        lableText:'Please Enter Subject of file' ,
                        onFiledSubmittedValue: (value)
                        {},
                        onvalidator: (value) {
                          return value.isEmpty ? 'Please Enter Subject of File.' : null;
                        },
                      ),
                      SizedBox(height: 30.h,),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [Text('Select Dept'), dropDownList()],
                      // ),
                      // SizedBox(height: 10.h,),
                      Obx(
                            () => controller.state.loading.value == false
                            ?  Center(
                          child:ReuseButton(
                              tittle: 'Select Images',
                              // loading: controller.state.loading.value,
                              onpress: () {
                                String docId = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                controller.dispatchfileDataOnFirebase(controller.documentId,
                                    controller.state.subjectController.text.trim(),
                                    // controller.state.deptName.value.trim(),
                                    controller.state.letterNumController.text.trim(),
                                    controller.state.serialNumcontroller.text.trim(),
                                    controller.state.receiverNameController.text.trim(),
                                    controller.state.receiverAddressController.text.trim(),
                                    controller.state.selectedDate);
                              }),
                            )
                            :CircularProgressIndicator(
                        color: AppColors.filesCircularProgessIndicatorColour,
                      ),
                      ),
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
