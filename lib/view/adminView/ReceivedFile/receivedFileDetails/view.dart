import 'package:amc_management/view/adminView/ReceivedFile/receivedFileDetails/controller.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../res/colors.dart';
import '../receivedFileSearchView/controller.dart';


class receivedFileDetailsView extends GetView<receivedFileDetailController> {
  String serialNum;
  String date;
  String receivedFrom;
  String receiverName;
  String receiverAddress;
  String id;
  // String dept;
  receivedFileDetailsView({
    super.key,
    required this.serialNum,
    required this.receivedFrom,
    required this.id,
    required this.receiverAddress,
    required this.receiverName,
    required this.date,
    // required this.dept,
  });

  // ... Your existing class definition ...

  @override
  Widget build(BuildContext context) {
    final Con1 =Get.put(SearchBarController());
    final controller =receivedFileDetailController();
    CarouselController buttonCarouselController = CarouselController();
    controller.fetchDataOfFiles(id);
    controller.fetchImageUrls(id).then((urls) {
      print("urls" + urls.toString());
      controller.state.fetchedImageUrls.value = List<String>.from(urls);
      print('fetch:'+controller.state.fetchedImageUrls.length.toString());
      controller.setFetchLoading(false);

    });
    return Scaffold(
      backgroundColor: AppColors.filesBgColour,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColour,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async{
                String docId = id;
                List<String> imageUrls = await controller.fetchImageUrls(docId);
                await controller.downloadImages(imageUrls);
              },
              icon: Icon(Icons.download_outlined),
            ),
          ),
          // IconButton(
          //   onPressed: () async{
          //     String docId = id;
          //     List<String> imageUrls = await controller.fetchImageUrls(docId);
          //     await controller.generatePDF(imageUrls);
          //     // controller.generatePDF(controller.fetchimageUrls);
          //     print('pdf create');
          //   },
          //   icon: Icon(Icons.picture_as_pdf),
          // ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [

              SizedBox(height: 10.h),
              // Images Section
              Expanded(
                child: Obx(() {
                  return controller.state.fetchedLoading.value == true
                      ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : Swiper(
                    itemCount: controller.state.fetchedImageUrls.length,
                    itemBuilder: (context, index) {
                      print('length:'+controller.state.fetchedImageUrls.length.toString());
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
                                controller.state.fetchedImageUrls.value[index]),
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
              SizedBox(height: 10,),
              // File Details Section
              Expanded(
                child: Obx(
                      () => controller.state.loaded.value == true
                      ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColour,
                    ),
                  )
                      : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        // Container for FileName and Dept
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(.8),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              reusebaleTextFields(
                                title: 'Date',
                                iconData: Icons.calendar_today_outlined,
                                value: date,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        // // Container for ReceivedFrom
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(.8),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.showserialNumDialogAlert(
                                  context,controller.state.serialNum.value.toString(),id
                              );
                            },
                            child: reusebaleTextFields(
                              title: 'serial number',
                              iconData: Icons.numbers_outlined,
                              value: controller.state.serialNum.value.toString(),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(.8),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap:(){
                          controller.showrecievednameDialogAlert(
                              context,controller.state.receiverName.value.toString(),id
                          );
                        },
                                child: reusebaleTextFields(
                                  title: 'Receiver Name',
                                  iconData: Icons.work_outline,
                                  value: controller.state.receiverName.value.toString(),
                                ),
                              ),
                              SizedBox(height: 15),
                              GestureDetector(
                                onTap: (){
                                  controller.showrecievedfromDialogAlert(context, controller.state.receiverFrom.value.toString(), id);
                                },
                                child: reusebaleTextFields(
                                  title: 'Received From',
                                  iconData: Icons.person_outlined,
                                  value: controller.state.receiverFrom.value.toString(),
                                ),
                              ),
                              SizedBox(height: 15),

                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(.8),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap:(){
                                 controller.showreceiverAddressDialogAlert (
                                    context,controller.state.receiverAddress.value.toString(),id
                                  );
                        },
                                child: reusebaleTextFieldsforAddressandSubject(
                                  title: 'Receiver Address',
                                  iconData: Icons.work_outline,
                                  value: controller.state.receiverAddress.value.toString(),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class reusebleRow extends StatelessWidget {
  final String title, value;
  final Color? iconColor, valueColor;
  final VoidCallback? onpress;
  final IconData iconData;

  reusebleRow({
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

class ScaffoldWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;

  const ScaffoldWidget({
    Key? key,
    required this.title,
    required this.child,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: child,
    );
  }
}
// class reusebaleTextFieldsforAddressandSubject extends StatelessWidget {
//   final String title, value;
//   final Color? iconColor, valueColor;
//   final VoidCallback? onpress;
//   final IconData iconData;
//
//   reusebaleTextFieldsforAddressandSubject({
//     Key? key,
//     required this.title,
//     this.iconColor,
//     this.onpress,
//     this.valueColor,
//     required this.iconData,
//     required this.value,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.iconButtonBgColour),
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: ListTile(
//         title: GestureDetector(
//           onTap: () {
//             onpress;
//           },
//           child: AbsorbPointer(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: title,
//                 border: InputBorder.none,
//               ),
//               style: Theme.of(context).textTheme.subtitle2,
//             ),
//           ),
//         ),
//         leading: Icon(
//           iconData,
//           color: iconColor,
//         ),
//         subtitle: Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColors.buttonBgColor),
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: valueColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
                hintStyle: GoogleFonts.poppins(
                    textStyle:TextStyle(
                        color: AppColors.iconButtonBgColour
                    )
                ),
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        leading: Icon(
          iconData,
          color: AppColors.iconButtonBgColour,
        ),
        trailing: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.iconButtonBgColour),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
                value,
                style: GoogleFonts.poppins(
                    textStyle:TextStyle(
                        color: AppColors.iconButtonBgColour
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}
class reusebaleTextFieldsforAddressandSubject extends StatelessWidget {
  final String title, value;
  final Color? iconColor, valueColor;
  final VoidCallback? onpress;
  final IconData iconData;

  reusebaleTextFieldsforAddressandSubject({
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
                hintStyle: GoogleFonts.poppins(
                    textStyle:TextStyle(
                        color: AppColors.iconButtonBgColour
                    )
                ),

                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        leading: Icon(
          iconData,
          color: AppColors.iconButtonBgColour,
        ),
        subtitle: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.iconButtonBgColour),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
                value,
                style: GoogleFonts.poppins(
                    textStyle:TextStyle(
                        color: AppColors.iconButtonBgColour
                    )
                )
            ),
          ),
        ),
      ),
    );
  }
}






