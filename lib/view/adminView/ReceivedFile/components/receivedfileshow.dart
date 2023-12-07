import 'package:amc_management/view/adminView/ReceivedFile/index.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/sharedComponents/tab_bar_setting.dart';
import '../../dispatchFile/dispatchfileshow.dart';

// ... Your existing imports ...

class receivedFileShowContainer extends StatelessWidget {
  String serialNum;
  String date;
  String receivedFrom;
  String receiverName;
  String receiverAddress;
  String id;
  // String dept;
   receivedFileShowContainer({
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
    final state = receivedFileState();
    CarouselController buttonCarouselController = CarouselController();
    final controller = Get.put<receivedFileController>(receivedFileController());
    controller.fetchDataOfFiles(id);
    controller.fetchImageUrls(id).then((urls) {
      print("urls" + urls.toString());
      controller.fetchedImageUrls = urls;
      controller.setFetchLoading(false);
    });
    // ... Your existing build method ...

    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColour,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          controller.downloadImages(controller.fetchedImageUrls);
                        },
                        icon: Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10.h),
              // Images Section
              Expanded(
                child: Obx(() {
                  return controller.fetchedLoading.value == true
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Swiper(
                          itemCount: controller.fetchedImageUrls.length,
                          itemBuilder: (context, index) {
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
                                      controller.fetchedImageUrls[index]),
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
                                    reusebleRow(
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
                                  color: AppColors.containerColor2,
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
                                  child: reusebleRow(
                                    title: 'ReceivedFrom',
                                    iconData: Icons.person_outlined,
                                    value: receivedFrom,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              // Container for FileNum and Date
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.containerColor3,
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
                                          id,
                                        );

                              },
                                      child: reusebleRow(
                                        title: 'SerialNum',
                                        iconData: Icons.format_list_numbered,
                                        value: controller.state.serialNum.value
                                            .toString(),
                                      ),
                                    ),
                                    SizedBox(height: 15),

                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              // Container for Department, Received From, and Details
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.containerColor4,
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
                                    reusebleRow(
                                      title: 'Receiver Name',
                                      iconData: Icons.work_outline,
                                      value: receiverName,
                                    ),
                                    SizedBox(height: 15),
                                    reusebleRow(
                                      title: 'Received From',
                                      iconData: Icons.person_outlined,
                                      value: receivedFrom,
                                    ),
                                    SizedBox(height: 15),

                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
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

