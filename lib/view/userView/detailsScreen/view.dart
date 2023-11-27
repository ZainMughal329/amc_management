import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart' as dio; // Alias the dio package
import 'package:path_provider/path_provider.dart';

import '../../../res/colors.dart';
import '../../../res/components/adminViewComponents/custom_button.dart';
import '../controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pdf/widgets.dart' as pw;
import '../controller.dart';

class UserViewImages extends StatelessWidget {
  final String id;

  UserViewImages({required this.id});

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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.blue, // Set your desired color
                      size: 20.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'IMAGES',
                      style: TextStyle(color: AppColors.titleTextColor, fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.blue, // Set your desired color
                      size: 20.sp,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '${controller.fetchedImageUrls.length}',
                      style: TextStyle(color: AppColors.titleTextColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),






          SizedBox(height: 15.h),
          Expanded(
            child: Obx(() {
              return controller.fetchedLoading.value == true
                  ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.appBarBgColour,
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
                        image: NetworkImage(controller.fetchedImageUrls[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                itemHeight: 350.h,
                itemWidth: 300.w,
                layout: SwiperLayout.STACK,
              );
            }),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ReuseButton(
              borderColor: Colors.blue,
              icon: Icons.download_outlined,
              tittle: 'Download All',
              onpress: () {
                controller.downloadImages(controller.fetchedImageUrls);
              },
            ),
          ),
        ],
      ),
    );
  }
}




