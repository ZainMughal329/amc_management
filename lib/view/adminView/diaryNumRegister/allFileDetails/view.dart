import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../res/colors.dart';
import 'controller.dart';

class diaryFilesDetailView extends GetView<diaryFilesDetailController> {
  String serialNum, senderName, senderAddress, receiverName, subject;
  String id;
  List<dynamic> dept;
  String date, fileDispatchDate;
  diaryFilesDetailView(
      {super.key,
      required this.serialNum,
      required this.senderName,
      required this.senderAddress,
      required this.receiverName,
      required this.subject,
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
      print('fetch:' + controller.fetchedImageUrls.length.toString());
      controller.setFetchLoading(false);
    });
    controller.fetchImageUrls(id);
    controller.fetchDataOfFiles(id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColour,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                controller.downloadImages(controller.fetchedImageUrls);
              },
              icon: Icon(Icons.download_outlined),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     controller.generatePDF(controller.fetchedImageUrls);
          //     print('pdf create');
          //   },
          //   icon: Icon(Icons.picture_as_pdf),
          // ),
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
                    : Column(
                        children: [
                          Swiper(
                            itemCount: controller.fetchedImageUrls.value.length,
                            itemBuilder: (context, index) {
                              print('length is:' +
                                  controller.fetchedImageUrls.value.length
                                      .toString());
                              print('length without value is:' +
                                  controller.fetchedImageUrls.length
                                      .toString());
                              controller.state.length.value =
                                  controller.fetchedImageUrls.value.length;
                              print(controller.state.length.value.toString() +
                                  'length');
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
                                    image: NetworkImage(controller
                                        .fetchedImageUrls.value[index]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                            itemHeight: 270.h,
                            itemWidth: 250.w,
                            layout: SwiperLayout.STACK,
                          ),
                        ],
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
                          color: AppColors.tittleColour,
                        ),
                      )
                    :
                    // Text('serial num' + controller.state.serialNum.value),
                    SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            // Container for FileName and Dept
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(.8),
                                // color: AppColors.containerColor1,
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
                                    onTap: () {
                                      controller.showserialNumDialogAlert(
                                          context,
                                          controller.state.serialNum.value
                                              .toString(),
                                          id);
                                    },
                                    child: reusebaleTextFields(
                                      title: 'SerialNum',
                                      iconData: Icons.format_list_numbered,
                                      value: controller.state.serialNum.value
                                          .toString(),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () {},
                                    child: ReusableTextFieldsforDepts(
                                      title: 'Dept',
                                      iconData: Icons.place_outlined,
                                      departmentNames: [dept.toString()]
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            // Container for ReceivedFrom
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
                                onTap: () {},
                                child: reusebaleTextFields(
                                  title: 'File Dispatch Date',
                                  iconData: Icons.person_outlined,
                                  value: fileDispatchDate,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            // // Container for FileNum and Date
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
                                  SizedBox(height: 15),
                                  reusebaleTextFields(
                                    title: 'Date',
                                    iconData: Icons.calendar_today_outlined,
                                    value: date,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            // // Container for Department, Received From, and Details
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(.8),
                                // color: AppColors.containerColor4,
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
                                    onTap: () {
                                      controller.senderNameDialogAlert(
                                        context,
                                        controller.state.senderName.value
                                            .toString(),
                                        id,
                                      );
                                    },
                                    child: reusebaleTextFields(
                                      title: 'Sender Name',
                                      iconData: Icons.work_outline,
                                      value: controller.state.senderName.value
                                          .toString(),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: (){
                                      controller.receiverNameDialogAlert(
                                        context,
                                        controller.state.receiverName.value
                                            .toString(),
                                        id,
                                      );
                                    },
                                    child: reusebaleTextFields(
                                      title: 'Receiver Name',
                                      iconData: Icons.person_outlined,
                                      value: controller.state.receiverName.value
                                          .toString(),
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
                                      controller.senderAddressDialogAlert(
                                        context,
                                        controller.state.senderAddress.value
                                            .toString(),
                                        id,
                                      );
                            },
                                    child: reusebaleTextFieldsforAddressandSubject(
                                      onpress: () {

                                      },
                                      title: 'Sender Address',
                                      iconData: Icons.format_list_numbered,
                                      value: controller.state.senderAddress.value
                                          .toString(),
                                    ),
                                  ),
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
                                      controller.fileSubjectDialogAlert(
                                        context,controller.state.subject.value.toString(),id
                                      );
                            },
                                    child: reusebaleTextFieldsforAddressandSubject(
                                        title: 'Subject Of File',
                                        iconData: Icons.subject,
                                        value: controller.state.subject.value.toString()
                                        // controller.state.senderName.value
                                        //     .toString(),
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
class ReusableTextFieldsforDepts extends StatelessWidget {
  final String title;
  final List<String> departmentNames;
  final Color? iconColor, valueColor;
  final VoidCallback? onpress;
  final IconData iconData;

  ReusableTextFieldsforDepts({
    Key? key,
    required this.title,
    this.iconColor,
    this.onpress,
    this.valueColor,
    required this.iconData,
    required this.departmentNames,
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
            onpress?.call();
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
              style:GoogleFonts.poppins(
                  textStyle:TextStyle(
                      color: AppColors.iconButtonBgColour
                  )
              ),
              controller: TextEditingController(
                text: '${departmentNames.length} departments',
              ),
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
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.arrow_drop_down,
                  color: AppColors.iconButtonBgColour
              ),
              itemBuilder: (context) {
                return departmentNames.map((deptName) {
                  return PopupMenuItem<String>(
                    value: deptName,
                    child: Text(deptName,
                    style: GoogleFonts.poppins(
                        textStyle:TextStyle(
                            color: AppColors.iconButtonBgColour
                        )
                    ),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
