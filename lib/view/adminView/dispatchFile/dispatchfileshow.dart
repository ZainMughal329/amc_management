

import 'package:amc_management/res/components/adminViewComponents/fileShowScreen.dart';
import 'package:amc_management/view/adminView/dispatchFile/index.dart';
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
      controller.fetchedImageUrls = urls;
      controller.setFetchLoading(false);
    });
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundColor: AppColors.buttonColour,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TabBar(
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(right: 20, left: 20),
                      indicator: CircleTabIndicator(
                          color: AppColors.lightActiveIconColor, radius: 4),
                      controller:controller.tabController,
                      labelColor: AppColors.unActiveTabElementColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          text: 'Images',
                        ),
                        Tab(
                          text: 'FilesDetails',
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 598.h,
                  width: double.infinity,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      Obx(() {
                        return controller.fetchedLoading.value == true
                            ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(

                              child:
                              // CarouselSlider.builder(
                              //     itemCount:
                              //         (controller.fetchedImageUrls.length /
                              //                 2)
                              //             .round(),
                              //     itemBuilder: (context, index, realIdx) {
                              //       final int first = index * 2;
                              //       final int second = first + 1;
                              //       return Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.center,
                              //         children: [first, second].map((idx) {
                              //           return Container(
                              //             height: 400,
                              //             margin: EdgeInsets.symmetric(
                              //                 horizontal: 10),
                              //             child: CachedNetworkImage(
                              //               imageUrl: controller
                              //                   .fetchedImageUrls[index],
                              //               placeholder: (context, url) =>
                              //                   CircularProgressIndicator(
                              //                 color: Colors.white,
                              //               ),
                              //               errorWidget:
                              //                   (context, url, error) =>
                              //                       Icon(Icons.error),
                              //             ),
                              //           );
                              //         }).toList(),
                              //       );
                              //     },
                              //     options: CarouselOptions(
                              //         aspectRatio: 2.0,
                              //         enlargeCenterPage: true,
                              //         viewportFraction: 1)),
                              GridView.builder(
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                                itemBuilder: (_, index) => Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                    controller.fetchedImageUrls[index],
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                itemCount: controller.fetchedImageUrls.length,
                              )),
                        );
                      }),
                      Obx(

                        ()=>controller.state.loaded.value==false? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.buttonColour,
                          ),
                        ):SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // Obx(
                              //     ()=> GestureDetector(
                              //     onTap: () {
                              //      controller.showFileNameDialogAlert(context, controller.state.nameFile.value.toString(), id);
                              //     },
                              //     child: ReuseableRow(
                              //         title: 'File Name',
                              //         iconData: Icons.drive_file_rename_outline_outlined,
                              //         value: controller.state.nameFile.value.toString()),
                              //   ),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: ReuseableRow(
                              //       title: 'Dept',
                              //       iconData: Icons.place_outlined,
                              //       value: Dept),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: ReuseableRow(
                                    title: 'Date',
                                    iconData: Icons.calendar_today_outlined,
                                    value: date),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Obx( ()=>
                                 GestureDetector(
                                  onTap: () {
                                    controller.showserialNumDialogAlert(context, controller.state.serialNum.value.toString(), id);
                                  },
                                  child: ReuseableRow(
                                      title: 'File Num',
                                      iconData: Icons.numbers_outlined,
                                      value: controller.state.serialNum.value.toString()),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: ReuseableRow(
                                    title: 'Received By',
                                    iconData: Icons.person_outlined,
                                    value: recieverName),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: ReuseableRow(
                                    title: 'Notification To',
                                    iconData: Icons.person_outlined,
                                    value: subject),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: ReuseableRow(
                              //       title: 'Details',
                              //       iconData: Icons.details_outlined,
                              //       value: details),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      )
                      // Obx(() =>controller.state.loaded.value==false?
                      //     Center(
                      //       child: CircularProgressIndicator(
                      //         color: AppColors.elevatedButtonColour,
                      //       )
                      //     ):SingleChildScrollView(
                      //   child: ,
                      // )
                      // )

                    ],
                  ),
                )

              ],
            ),
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
