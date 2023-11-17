import 'package:amc_management/view/adminView/addFile/index.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../res/colors.dart';
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
                                padding: const EdgeInsets.only(top: 10,bottom: 50),
                                child: Container(
                                    child:

                                    // Column(
                                    //   children: <Widget>[
                                    //     Expanded(
                                    //       child: Swiper(
                                    //         itemBuilder: (context, index) {
                                    //           return Image.network(
                                    //             controller.fetchedImageUrls[index],
                                    //             fit: BoxFit.fill,
                                    //           );
                                    //         },
                                    //         autoplay: true,
                                    //         itemCount: controller.fetchedImageUrls.length,
                                    //         pagination: SwiperPagination(
                                    //             margin: EdgeInsets.zero,
                                    //             builder: SwiperCustomPagination(builder: (context, config) {
                                    //               return ConstrainedBox(
                                    //                 child: Container(
                                    //                   color: Colors.white,
                                    //                   child: Text(
                                    //                     '${'Hamza'[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}',
                                    //                     style: const TextStyle(fontSize: 20.0),
                                    //                   ),
                                    //                 ),
                                    //                 constraints: const BoxConstraints.expand(height: 50.0),
                                    //               );
                                    //             })),
                                    //         control: const SwiperControl(),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       child: Swiper(
                                    //         itemBuilder: (context, index) {
                                    //           return Image.network(
                                    //             controller.fetchedImageUrls[index],
                                    //             fit: BoxFit.fill,
                                    //           );
                                    //         },
                                    //         autoplay: true,
                                    //         itemCount: controller.fetchedImageUrls.length,
                                    //         pagination: SwiperPagination(
                                    //             margin: EdgeInsets.zero,
                                    //             builder: SwiperCustomPagination(builder: (context, config) {
                                    //               return ConstrainedBox(
                                    //                 child: Row(
                                    //                   children: <Widget>[
                                    //                     Text(
                                    //                       '${'wahab'[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}',
                                    //                       style: const TextStyle(fontSize: 20.0),
                                    //                     ),
                                    //                     Expanded(
                                    //                       child: Align(
                                    //                         alignment: Alignment.centerRight,
                                    //                         child: const DotSwiperPaginationBuilder(
                                    //                             color: Colors.black12,
                                    //                             activeColor: Colors.black,
                                    //                             size: 10.0,
                                    //                             activeSize: 20.0)
                                    //                             .build(context, config),
                                    //                       ),
                                    //                     )
                                    //                   ],
                                    //                 ),
                                    //                 constraints: const BoxConstraints.expand(height: 50.0),
                                    //               );
                                    //             })),
                                    //         control: const SwiperControl(color: Colors.redAccent),
                                    //       ),
                                    //     )
                                    //   ],
                                    // )



                                    Swiper(
                                      // layout: SwiperLayout.CUSTOM,
                                      //   customLayoutOption: CustomLayoutOption(startIndex: 1,
                                      //   stateCount: controller.fetchedImageUrls.length
                                      //   )..addRotate([
                                      //     90.0/180,
                                      //     0.0,
                                      //     45.0/180
                                      //   ])..addTranslate([
                                      //     Offset(-370.0, -40.0),
                                      //     Offset(0.0, 0.0),
                                      //     Offset(370.0, -40.0)
                                      //   ]),
                                      // itemWidth: double.infinity,
                                      // itemHeight: 558.h,
                                        itemCount:controller.fetchedImageUrls.length,
                                      itemBuilder: (context,index){
                                          return  Image(image: NetworkImage(controller.fetchedImageUrls[index]),
                                          fit: BoxFit.fill,
                                          );
                                          //   CachedNetworkImage(imageUrl: controller.fetchedImageUrls[index],
                                          //     placeholder: (context, url) =>
                                          //                 CircularProgressIndicator(
                                          //               color: Colors.white,
                                          //             ),
                                          //             errorWidget:
                                          //                 (context, url, error) =>
                                          //                     Icon(Icons.error),
                                          // );
                                      },

                                      indicatorLayout: PageIndicatorLayout.COLOR,
                                      scrollDirection: Axis.vertical,
                                      // pagination:
                                      // const SwiperPagination(builder: SwiperPagination.fraction),
                                      pagination: const SwiperPagination(alignment: Alignment.centerRight,
                                      // margin: EdgeInsets.all(100.0)
                                      ),
                                      autoplay: false,

                                      // pagination: const SwiperPagination(),
                                      control: const SwiperControl(),
                                      // containerHeight: 100.h,
                                      // containerWidth: double.infinity,
                                    )









                                  //       GridView.builder(
                                  //   gridDelegate:
                                  //       SliverGridDelegateWithFixedCrossAxisCount(
                                  //           crossAxisCount: 2),
                                  //   itemBuilder: (_, index) => Container(
                                  //     height: 100,
                                  //     width: 100,
                                  //     child: Image.network(
                                  //       controller.fetchedImageUrls[index],
                                  //       height: 100,
                                  //       width: 100,
                                  //     ),
                                  //   ),
                                  //   itemCount: controller.fetchedImageUrls.length,
                                  // )
                                ),
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

