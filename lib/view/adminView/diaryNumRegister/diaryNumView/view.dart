


import 'package:amc_management/view/adminView/diaryNumRegister/allFilesList/view.dart';
import 'package:amc_management/view/adminView/diaryNumRegister/dataUplaodForm/index.dart';
import 'package:amc_management/view/adminView/diaryNumRegister/diaryNumView/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/sharedComponents/tab_bar_setting.dart';

class diaryNumView extends GetView<diaryNumberController> {
  const diaryNumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary number register'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.filesBgColour,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child:Column(
        children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Align(
        //     alignment: Alignment.topLeft,
        //     child: CircleAvatar(
        //       backgroundColor: AppColors.filesIconButtonBgColour,
        //       child: IconButton(
        //         onPressed: () {
        //           Get.back();
        //         },
        //         icon: Icon(
        //           Icons.arrow_back,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 10.h),
        Align(
          alignment: Alignment.topLeft,
          child: TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 20, left: 20),
            indicator: CircleTabIndicator(
              color: AppColors.lightActiveIconColor,
              radius: 4,
            ),
            controller: controller.tabController,
            labelColor: AppColors.unActiveIconColor,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Text(
                  'DiaryNum Form',
              style: TextStyle(fontWeight: FontWeight.bold,
              ),
                ),
                // text: 'DiaryNum Form',
              ),
              Tab(
                child: Text('Files',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      // color: AppColors.sessionPageTextColor
                  ),

                ),
                // text: 'Files',
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),

        Container(
          // color: Colors.red,
          height: 590,
          width: double.infinity,
          child: TabBarView(
            controller: controller.tabController,
            children: [
              diaryNumberForm(),
              allFilesView(),
            ],
          ),
        ),
        ],
        )

      ),
    );
  }
}

