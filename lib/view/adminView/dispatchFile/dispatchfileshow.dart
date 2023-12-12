

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
                        return controller.fetchedLoading.value==true?Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.sessionPageBgColor,
                            ),
                          ),
                        ):Swiper(
                            itemCount:controller.fetchedImageUrls.value.length,
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
                                      controller.fetchedImageUrls.value[index],

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
              Expanded(
                child: Obx(
                      ()=>controller.state.loaded.value==true? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColour,
                    ),
                  ):SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.containerColor1,
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
                                  controller.showserialNumDialogAlert(
                                      context,
                                      controller.state.serialNum.value
                                          .toString(),
                                      id);
                                },
                                child: reusebaleTextFields(

                                  title: 'SerialNum',
                                  iconData: Icons.format_list_numbered,
                                  value: serialNum
                                  // controller.state.serialNum.value
                                  //     .toString(),
                                ),
                              ),
                              SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {},
                                child: reusebaleTextFields(
                                  title: 'Letter Number',
                                  iconData: Icons.person_outlined,
                                  value:letterNum,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.containerColor1,
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
                                onTap: () {},
                                child: reusebaleTextFields(
                                    title: 'Date',
                                    iconData: Icons.calendar_today_outlined,
                                    value: date),
                              ),
                              SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {},
                                child: reusebaleTextFields(
                                  title: 'Receiver Name',
                                  iconData: Icons.person_outlined,
                                  value:recieverName,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.containerColor1,
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
                                  onTap: () {},
                                  child: reusebaleTextFieldsforAddressandSubject(
                                      title: 'Receiver Address',
                                      iconData: Icons.house_outlined,
                                      value: receiverAddress),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.containerColor1,
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
                                onTap: () {},
                                child: reusebaleTextFieldsforAddressandSubject(
                                  title: 'Subject of File',
                                  iconData: Icons.person_outlined,
                                  value:subject,
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
      )
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
        subtitle: Container(
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




