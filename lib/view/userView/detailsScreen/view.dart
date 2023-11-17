import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_button.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart' as dio; // Alias the dio package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller.dart';

class userViewImages extends StatelessWidget {
  String id;

  userViewImages({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<userViewController>(userViewController());
    controller.fetchImageUrls(id).then((urls) {
      print("urls" + urls.toString());
      controller.fetchedImageUrls = List<String>.from(urls);
      controller.setFetchLoading(false);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColour,
        actions: [
          IconButton(
            onPressed: () {
             controller.downloadImages(controller.fetchedImageUrls);
            },
            icon: Icon(Icons.download_outlined),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Scaffold(
        backgroundColor: AppColors.scaffoldBgColour,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('IMAGES',style: TextStyle(
                    color: AppColors.cardTextColourS,fontSize: 20
                  ),),
                  Text(controller.fetchedImageUrls.length.toString()),
                ],
              ),
            ),
            SizedBox(height: 15.h,),
            Obx(() {
              return controller.fetchedLoading.value == true
                  ? Container(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.appBarBgColour,
                  ),
                ),
              )
                  : Center(
                child: Swiper(
                  itemCount: controller.fetchedImageUrls.length,
                  itemBuilder: (context, index) {
                    return Image(
                      image: NetworkImage(controller.fetchedImageUrls[index]),
                      fit: BoxFit.fill,
                    );
                  },
                  itemHeight: 550,
                  itemWidth: 300.0,
                  layout: SwiperLayout.STACK,
                ),
              );
            }),
            SizedBox(height: 30.h,),
            ReuseButton(
                icon: Icons.download_outlined,
                tittle: 'Download', onpress: (){
              controller.downloadImages(controller.fetchedImageUrls);
            })
          ],
        ),
      ),
    );
  }
}

// Future<void> _downloadImages(List<String> imageUrls) async {
//   dio.Dio dioInstance = dio.Dio(); // Use the aliased dio package
//
//   for (int i = 0; i < imageUrls.length; i++) {
//     try {
//       dio.Response response = await dioInstance.get(
//         imageUrls[i],
//         options: dio.Options(responseType: dio.ResponseType.bytes),
//       );
//       Get.snackbar('Success', 'Image Download');
//       // Save the image to local storage or handle it as needed
//       // For example, you can use the path_provider package to get the local directory and save the image there.
//       // Ensure you have the necessary permissions to write to the device's local storage.
//     } catch (error) {
//       print('Error downloading image: $error');
//     }
//   }
// }
