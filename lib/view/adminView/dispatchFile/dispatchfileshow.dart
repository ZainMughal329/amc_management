

import 'package:amc_management/res/components/adminViewComponents/fileShowScreen.dart';
import 'package:amc_management/view/adminView/dispatchFile/index.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/colors.dart';
import '../../../res/components/adminViewComponents/sharedComponents/tab_bar_setting.dart';
class dispatchFileShowContainer extends StatelessWidget {
  String subject;
  String recieverName;
  // String img;
  String receiverAddress;
  String serialNum;
  String letterNum;
  // String Dept;
  String id;

   String date;
   dispatchFileShowContainer({super.key,
     required this.date,
    required this.receiverAddress,
     required this.recieverName,
     required this.subject,
     required this.serialNum,
     required this.letterNum,
     required this.id,
     // required this.Dept
     // required this.img,
  });

  @override
  Widget build(BuildContext context) {

    final controller = Get.put<dispatchController>(dispatchController());
    controller.fetchDataOfFile(id);
    controller.FetchImageUrls(id).then((urls) {
      print("urls" + urls.toString());
      controller.fetchedImageUrls.value = List<String>.from(urls);
      print('fetch:'+controller.fetchedImageUrls.length.toString());
      controller.setFetchLoading(false);
    });
    // controller.FetchImageUrls(id).then((urls) {
    //   print("urls" + urls.toString());
    //   controller.fetchedImageUrls.value = urls;
    //   controller.setFetchLoading(false);
    // });
    return  Scaffold(
        backgroundColor: AppColors.filesBgColour,
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColour,
        actions: [
          IconButton(
            onPressed: () {
              // controller.downloadImages(controller.fetchedImageUrls);
            },
            icon: Icon(Icons.download_outlined),
          ),
          IconButton(
            onPressed: () {
              // controller.generatePDF(controller.fetchedImageUrls);
              print('pdf create');
            },
            icon: Icon(Icons.picture_as_pdf),
          ),
        ],
      ),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Expanded(child:
                  Obx(
                      (){
                        return controller.fetchedLoading.value==false?Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.sessionPageBgColor,
                            ),
                          ),
                        ):Swiper(
                            itemCount:controller.fetchedImageUrls.length,
                          itemBuilder: (context, index){
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
                                      controller.fetchedImageUrls[index],

                                    ),
                                    fit: BoxFit.fill,
                                  ),

                                ),
                              );

                          },
                          itemHeight: 270.h,
                          itemWidth: 250.w,
                          layout: SwiperLayout.STACK,
                        );
                      }
                  )
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              // Obx(
              //
              //       ()=>controller.state.loaded.value==false? Center(
              //     child: CircularProgressIndicator(
              //       color: AppColors.buttonColour,
              //     ),
              //   ):SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         SizedBox(
              //           height: 20.h,
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         // Obx(
              //         //     ()=> GestureDetector(
              //         //     onTap: () {
              //         //      controller.showFileNameDialogAlert(context, controller.state.nameFile.value.toString(), id);
              //         //     },
              //         //     child: ReuseableRow(
              //         //         title: 'File Name',
              //         //         iconData: Icons.drive_file_rename_outline_outlined,
              //         //         value: controller.state.nameFile.value.toString()),
              //         //   ),
              //         // ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         // GestureDetector(
              //         //   onTap: () {},
              //         //   child: ReuseableRow(
              //         //       title: 'Dept',
              //         //       iconData: Icons.place_outlined,
              //         //       value: Dept),
              //         // ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         GestureDetector(
              //           onTap: () {},
              //           child: ReuseableRow(
              //               title: 'Date',
              //               iconData: Icons.calendar_today_outlined,
              //               value: date),
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         Obx( ()=>
              //             GestureDetector(
              //               onTap: () {
              //                 controller.showserialNumDialogAlert(context, controller.state.serialNum.value.toString(), id);
              //               },
              //               child: ReuseableRow(
              //                   title: 'File Num',
              //                   iconData: Icons.numbers_outlined,
              //                   value: controller.state.serialNum.value.toString()),
              //             ),
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         GestureDetector(
              //           onTap: () {},
              //           child: ReuseableRow(
              //               title: 'Received By',
              //               iconData: Icons.person_outlined,
              //               value: recieverName),
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         GestureDetector(
              //           onTap: () {},
              //           child: ReuseableRow(
              //               title: 'Notification To',
              //               iconData: Icons.person_outlined,
              //               value: subject),
              //         ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //         // GestureDetector(
              //         //   onTap: () {},
              //         //   child: ReuseableRow(
              //         //       title: 'Details',
              //         //       iconData: Icons.details_outlined,
              //         //       value: details),
              //         // ),
              //         SizedBox(
              //           height: 15,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),


            ],
          ),
        ),
      )
    );
  }
}
class ReuseableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  ReuseableRow(
      {Key? key,
        required this.title,
        required this.iconData,
        required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            leading: Icon(
              iconData,
              color: AppColors.lightActiveIconColor,
            ),
            trailing: Text(value, style: Theme.of(context).textTheme.subtitle2),
          ),
          Divider(
            color: AppColors.buttonBgColor.withOpacity(0.4),
          )
        ],
      ),
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


