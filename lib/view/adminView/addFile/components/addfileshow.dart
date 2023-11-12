import 'package:amc_management/view/adminView/addFile/index.dart';
import 'package:amc_management/view/adminView/dispatchFile/components/listOfImages/listofimages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/fileShowScreen.dart';
import '../../../../res/components/adminViewComponents/tab_bar_setting.dart';

class addFileShowContainer extends StatelessWidget {
  // final  String img;
  String fileNum;
  String name;
  String from;
  String date;
  String id;
  String dept;
  String details;

  addFileShowContainer({
    super.key,
    required this.name,
    required this.fileNum,
    required this.from,
    required this.id,
    required this.date,
    required this.dept,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final state = addFileState();
    CarouselController buttonCarouselController = CarouselController();
    final controller = Get.put<addFileController>(addFileController());
    controller.fetchDataOfFiles(id);
    controller.fetchImageUrls(id).then((urls) {
      print("urls" + urls.toString());
      controller.fetchedImageUrls = urls;
      controller.setFetchLoading(false);
    });
    return Scaffold(
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
                          backgroundColor: AppColors.elevatedButtonColour,
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
                        controller: controller.tabController,
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
                                            crossAxisCount: 2),
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
                          () => controller.state.loaded.value == false
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.elevatedButtonColour,
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Obx(
                                        () => GestureDetector(
                                          onTap: () {
                                            controller.showFileNameDialogAlert(
                                                context,
                                                controller.state.nameFile.value
                                                    .toString(),
                                                id);
                                          },
                                          child: ReuseableRow(
                                            title: 'FileName',
                                            iconData:
                                                Icons.drive_file_rename_outline,
                                            value: controller
                                                .state.nameFile.value
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: ReuseableRow(
                                            title: 'Dept',
                                            iconData: Icons.place_outlined,
                                            value: dept),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: ReuseableRow(
                                            title: 'ReceivedFrom',
                                            iconData: Icons.person_outlined,
                                            value: from),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Obx(
                                        () => GestureDetector(
                                          onTap: () {
                                            controller.showFileNumDialogAlert(
                                                context,
                                                controller.state.fileNum.value
                                                    .toString(),
                                                id);
                                          },
                                          child: ReuseableRow(
                                            title: 'FileNum',
                                            iconData:
                                                Icons.format_list_numbered,
                                            value: controller
                                                .state.fileNum.value
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: ReuseableRow(
                                            title: 'Date',
                                            iconData:
                                                Icons.calendar_today_outlined,
                                            value: date),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: ReuseableRow(
                                            title: 'Details',
                                            iconData: Icons.details_outlined,
                                            value: details),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

//Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, // Adjust the number of columns as needed
//                 ),
//                 itemCount: controller.fetchedImageUrls.length,
//                 itemBuilder: (context, index) {
//                   return CachedNetworkImage(
//                     imageUrl: controller.fetchedImageUrls[index],
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   );
//                 },
//               ),
//
//            );
// class ReuseableRow extends StatelessWidget {
//   final String lableText, value;
//   final Icon? prefixIcon;
//   ReuseableRow(
//       {Key? key,
//         required this.lableText,
//         required this.prefixIcon,
//         required this.value})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Column(
//         children: [
//           TextFormField(
//             // focusNode: focusNode,
//             // onFieldSubmitted: onFiledSubmittedValue,
//             // validator: onvalidator,
//             // keyboardType: keyboardType,
//             style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0,fontSize: 15.sp),
//             decoration: InputDecoration(
//               prefixIcon: prefixIcon,
//               labelText: lableText,
//               contentPadding: EdgeInsets.all(15),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10)
//               ),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10)
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
