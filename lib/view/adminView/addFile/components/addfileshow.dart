import 'package:amc_management/view/adminView/addFile/index.dart';
import 'package:amc_management/view/adminView/dispatchFile/components/listOfImages/listofimages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/fileShowScreen.dart';

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
    final controller =Get.put<addFileController>(addFileController());
    controller.fetchImageUrls(id).then((urls) {
      print("urls"+urls.toString());
      controller.fetchedImageUrls =  urls;
      controller.setFetchLoading(false);
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      resizeToAvoidBottomInset: false,
       body:
      Column(
        children: [
          BeautifulCard(
                receiverFrom: from,
                 fileNumber: fileNum,
                 fileName: name,
                 deptName: dept,
                 fileDetails: details),
          Obx((){
            return controller.fetchedLoading.value == true ? Container(child: Center(child: CircularProgressIndicator(),),) :
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Adjust the number of columns as needed
                ),
                itemCount: controller.fetchedImageUrls.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: controller.fetchedImageUrls[index],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },
              ),
            );
          })
        ],
      ),

    );
  }
}
