import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../res/colors.dart';
import 'controller.dart';

class diaryFilesDetailView extends GetView<diaryFilesDetailController> {
  String serialNum, senderName, senderAddress, receiverName;
  String id;
     List<dynamic> dept;
  String date, fileDispatchDate;
  diaryFilesDetailView(
      {super.key,
      required this.serialNum,
      required this.senderName,
      required this.senderAddress,
      required this.receiverName,
      required this.id,
      required this.dept,
      required this.date,
      required this.fileDispatchDate});


  @override
  Widget build(BuildContext context) {

    final controller = Get.put(diaryFilesDetailController());
    CarouselController buttonCarouselController = CarouselController();
    print('id:' + id.toString());
    print('length of : ' + controller.fetchImageUrls(id).toString());
    controller.fetchImageUrls(id).then((urls) {
      print("urls" + urls.toString());
      controller.fetchedImageUrls.value = List<String>.from(urls);
      print('fetch:'+controller.fetchedImageUrls.length.toString());
      controller.setFetchLoading(false);

    });
    // controller.fetchDataOfFiles(id);
    // controller.fetchImageUrls(id).then((urls) {
    //   print("urls" + urls.toString());
    //   controller.fetchedImageUrls = urls;
    //   controller.setFetchLoading(false);
    // });
    controller.fetchImageUrls(id);
    controller.fetchDataOfFiles(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColour,
        actions: [
          IconButton(
            onPressed: () {
              controller.downloadImages(controller.fetchedImageUrls);
            },
            icon: Icon(Icons.download_outlined),
          ),
          IconButton(
            onPressed: () {
              controller.generatePDF(controller.fetchedImageUrls);
              print('pdf create');
            },
            icon: Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
      backgroundColor: AppColors.filesBgColour,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [

            SizedBox(height: 10.h),
            // Images Section
            Expanded(
              child: Obx(() {
                return controller.fetchedLoading.value == false
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.sessionPageBgColor,
                          ),
                        ),
                      )
                    : Swiper(
                        itemCount: controller.fetchedImageUrls.value.length,
                        itemBuilder: (context, index) {
                          print('length is:'+ controller.fetchedImageUrls.value.length.toString());
                          print('length without value is:'+ controller.fetchedImageUrls.length.toString());

                          return Container(
                            margin: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image(
                                image: NetworkImage(
                                    controller.fetchedImageUrls.value[index]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                        itemHeight: 270.h,
                        itemWidth: 250.w,
                        layout: SwiperLayout.STACK,
                      );
              }),
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            // File Details Section
            Expanded(
              child: Obx(
                () => controller.state.loaded.value == false
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttonColour,
                        ),
                      )
                    :
                    Text('serial num' + controller.state.serialNum.value),
                // Column(
                //       children: [
                //         SizedBox(height: 20.h),
                //         // Container for FileName and Dept
                //         Container(
                //           padding: EdgeInsets.all(16),
                //           decoration: BoxDecoration(
                //             color: AppColors.containerColor1,
                //             borderRadius: BorderRadius.circular(12),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: AppColors.shadowColor,
                //                 blurRadius: 4,
                //                 offset: Offset(0, 2),
                //               ),
                //             ],
                //           ),
                //           child: Column(
                //             children: [
                //               GestureDetector(
                //                 onTap:(){
                //                   controller.showserialNumDialogAlert(
                //                       context,
                //                       controller.state.serialNum.value
                //                           .toString(),
                //                   id);
                //         },
                //                 child: reusebaleTextFields(
                //
                //                   title: 'SerialNum',
                //                   iconData: Icons.format_list_numbered,
                //                   value: controller.state.serialNum.value
                //                       .toString(),
                //                 ),
                //               ),
                //               SizedBox(height: 15),
                //               GestureDetector(
                //                 onTap: () {},
                //                 child: ReusableTextFieldsForDept(
                //                   title: 'Dept',
                //                   iconData: Icons.place_outlined,
                //                   values: dept,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         SizedBox(height: 15),
                //         // Container for ReceivedFrom
                //         Container(
                //           padding: EdgeInsets.all(16),
                //           decoration: BoxDecoration(
                //             color: AppColors.containerColor2,
                //             borderRadius: BorderRadius.circular(12),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: AppColors.shadowColor,
                //                 blurRadius: 4,
                //                 offset: Offset(0, 2),
                //               ),
                //             ],
                //           ),
                //           child: GestureDetector(
                //             onTap: () {},
                //             child: reusebaleTextFields(
                //               title: 'File Dispatch Date',
                //               iconData: Icons.person_outlined,
                //               value: fileDispatchDate,
                //             ),
                //           ),
                //         ),
                //         SizedBox(height: 15),
                //         // Container for FileNum and Date
                //         Container(
                //           padding: EdgeInsets.all(16),
                //           decoration: BoxDecoration(
                //             color: AppColors.containerColor3,
                //             borderRadius: BorderRadius.circular(12),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: AppColors.shadowColor,
                //                 blurRadius: 4,
                //                 offset: Offset(0, 2),
                //               ),
                //             ],
                //           ),
                //           child: Column(
                //             children: [
                //               reusebaleTextFields(
                //                 onpress: () {
                //                   controller.senderAddressDialogAlert(
                //                     context,
                //                     controller.state.senderAddress.value
                //                         .toString(),
                //                     id,
                //                   );
                //                 },
                //                 title: 'Sender Address',
                //                 iconData: Icons.format_list_numbered,
                //                 value: controller.state.senderAddress.value
                //                     .toString(),
                //               ),
                //               SizedBox(height: 15),
                //               reusebaleTextFields(
                //                 title: 'Date',
                //                 iconData: Icons.calendar_today_outlined,
                //                 value: date,
                //               ),
                //             ],
                //           ),
                //         ),
                //         SizedBox(height: 15),
                //         // Container for Department, Received From, and Details
                //         Container(
                //           padding: EdgeInsets.all(16),
                //           decoration: BoxDecoration(
                //             color: AppColors.containerColor4,
                //             borderRadius: BorderRadius.circular(12),
                //             boxShadow: [
                //               BoxShadow(
                //                 color: AppColors.shadowColor,
                //                 blurRadius: 4,
                //                 offset: Offset(0, 2),
                //               ),
                //             ],
                //           ),
                //           child: Column(
                //             children: [
                //               reusebaleTextFields(
                //                 onpress: () {
                //                   controller.senderNameDialogAlert(
                //                     context,
                //                     controller.state.senderName.value
                //                         .toString(),
                //                     id,
                //                   );
                //                 },
                //                 title: 'Sender Name',
                //                 iconData: Icons.work_outline,
                //                 value: controller.state.senderName.value
                //                     .toString(),
                //               ),
                //               SizedBox(height: 15),
                //               reusebaleTextFields(
                //                 onpress: () {
                //                   controller.receiverNameDialogAlert(
                //                     context,
                //                     controller.state.receiverName.value
                //                         .toString(),
                //                     id,
                //                   );
                //                 },
                //                 title: 'Receiver Name',
                //                 iconData: Icons.person_outlined,
                //                 value: controller.state.receiverName.value
                //                     .toString(),
                //               ),
                //               SizedBox(height: 15),
                //             ],
                //           ),
                //         ),
                //         SizedBox(height: 15),
                //       ],
                //     ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class reusebaleTextFields extends StatelessWidget {
  final String title, value;
  final Color? iconColor, valueColor;
  final VoidCallback? onpress;
  final IconData iconData;

  reusebaleTextFields({
    Key? key,
    required this.title,
    this.iconColor,
    this.onpress,
    this.valueColor,
    required this.iconData,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.iconButtonBgColour),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        title: GestureDetector(
          onTap: () {
            onpress;
          },
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        leading: Icon(
          iconData,
          color: iconColor,
        ),
        trailing: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.buttonBgColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableTextFieldsForDept extends StatelessWidget {
  final String title;
  final List<dynamic> values;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final IconData iconData;

  ReusableTextFieldsForDept({
    Key? key,
    required this.title,
    required this.values,
    this.iconColor,
    this.onPressed,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.iconButtonBgColour),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        title: GestureDetector(
          onTap: onPressed,
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        leading: Icon(
          iconData,
          color: iconColor,
        ),
        trailing: values.length == 1
            ? Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.buttonBgColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              values.first,
              style: TextStyle(
                color: iconColor,
              ),
            ),
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (String value in values)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.buttonBgColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.only(right: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: iconColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

