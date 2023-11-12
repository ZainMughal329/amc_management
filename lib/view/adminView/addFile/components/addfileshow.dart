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
  String id;
  String dept;
  String details;
  addFileShowContainer({
    super.key,
    required this.name,
    required this.fileNum,
    required this.from,
    required this.id,
    required this.dept,
    required this.details,
  });
  @override
  Widget build(BuildContext context) {
    final state = addFileState();
    CarouselController buttonCarouselController = CarouselController();
    final controller =Get.put<addFileController>(addFileController());
    controller.fetchImageUrls(id).then((urls) {
      print("urls"+urls.toString());
      controller.fetchedImageUrls =  urls;
      controller.setFetchLoading(false);
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      resizeToAvoidBottomInset: false,
       appBar: AppBar(
         title: Text('File Details'),
       ),
       body:
           SingleChildScrollView(
             child: SafeArea(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 15),
                 child: Column(
                   children: [
                     SizedBox(height: 15.h,),
                     Container(
                       child: Align(
                         alignment: Alignment.topLeft,
                         child: TabBar(
                           isScrollable: true,
                           labelPadding:
                           EdgeInsets.only(right: 20,left: 20),
                           indicator: CircleTabIndicator(color: AppColors.lightActiveIconColor,radius: 4),
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
                     Container(height: 598.h,
                       width: double.infinity,
                       child: TabBarView(
                         controller: controller.tabController,
                         children: [
                           Obx((){
                             return controller.fetchedLoading.value == true ? Container(child: Center(child: CircularProgressIndicator(),),) :
                             Container(
                                 child:
                                 CarouselSlider.builder(itemCount: (controller.fetchedImageUrls.length/2).round(),
                                     // .round(),
                                     itemBuilder: (context,index,realIdx){
                                       final int first = index * 2;
                                       final int second = first + 1 ;
                                       return SingleChildScrollView(
                                         child: Row(
                                           children: [
                                             first, second
                                           ].map((idx){
                                             return Expanded(
                                                 // flex: 1,
                                                 child:
                                                 Container(
                                                   height: 400,
                                                   // width: double.infinity,
                                                   margin: EdgeInsets.symmetric(horizontal: 10),
                                                   child:CachedNetworkImage(
                                                     imageUrl: controller.fetchedImageUrls[index],
                                                     placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                                                     errorWidget: (context, url, error) => Icon(Icons.error),
                                                   ),
                                                 )
                                             );
                                           }).toList(),

                                         ),
                                       );

                                     },
                                     options:CarouselOptions(
                                         aspectRatio:4.0,
                                         enlargeCenterPage: true,
                                         viewportFraction: 1
                                     ))
                             );
                           }),

                           // BeautifulCard(
                           //     receiverFrom: from,
                           //     fileNumber: fileNum,
                           //     fileName: name,
                           //     deptName: dept,
                           //     fileDetails: details),
                          Column(
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              GestureDetector(
                                onTap: (){
                                  controller.showFileNameDialogAlert(context,
                                      name);
                                },
                                child: ReuseableRow(
                                    title: 'FileName',
                                    iconData: Icons.drive_file_rename_outline,
                                    value: name),
                              ),
                              SizedBox(height: 15,),
                              GestureDetector(
                                onTap: (){

                                },
                                child: ReuseableRow(
                                    title: 'Dept',
                                    iconData: Icons.drive_file_rename_outline,
                                    value: dept),
                              ),
                              SizedBox(height: 15,),
                              GestureDetector(
                                onTap: (){

                                },
                                child: ReuseableRow(
                                    title: 'ReceivedFrom',
                                    iconData: Icons.drive_file_rename_outline,
                                    value: from),
                              ),
                              SizedBox(height: 15,),
                              GestureDetector(
                                onTap: (){

                                },
                                child: ReuseableRow(
                                    title: 'FileNum',
                                    iconData: Icons.drive_file_rename_outline,
                                    value: fileNum),
                              ),
                              SizedBox(height: 15,),
                              GestureDetector(
                                onTap: (){

                                },
                                child: ReuseableRow(
                                    title: 'Details',
                                    iconData: Icons.drive_file_rename_outline,
                                    value: details),
                              ),
                              SizedBox(height: 15,),

                            ],
                          )

                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           )

    );
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