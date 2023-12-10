
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../res/colors.dart';
import '../../../res/components/adminViewComponents/custom_button.dart';
import '../../../res/components/adminViewComponents/sharedComponents/tab_bar_setting.dart';
import 'components/disptachfileUploadForm.dart';
import 'components/filesListViewbuilder.dart';
import 'index.dart';

class dispatchView extends GetView<dispatchController> {
  const dispatchView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.filesBgColour,
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: AppColors.fileTabBarIconButtonColor,
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
          ),
          SizedBox(height: 10.h),
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
                      'dispatchFile',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold,)
                      )
                  ),
                ),
                Tab(
                  child: Text(
                      'Files',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold,)
                      )
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 598.h,
            width: double.infinity,
            child: TabBarView(
              controller: controller.tabController,
              children: [
                dispatchFileForm(),
                FileList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




// import 'dart:io';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:amc_management/model/dispatch_model/dispatch_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../res/colors.dart';
// import '../../../res/components/adminViewComponents/custom_button.dart';
// import '../../../res/components/adminViewComponents/tab_bar_setting.dart';
// import 'components/disptachfileUploadForm.dart';
// import 'components/filesListViewbuilder.dart';
// import 'index.dart';
//
// class dispatchView extends GetView<dispatchController> {
//   const dispatchView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               children: [
//                 SizedBox(height: 15.h,),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Align(
//                       alignment: Alignment.topLeft,
//                       child: CircleAvatar(
//                         backgroundColor: AppColors.buttonColour,
//                         child: IconButton(
//                             onPressed: () {
//                               Get.back();
//                             },
//                             icon: Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                             )),
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Container(
//                   child: Align(
//                     alignment: Alignment.topLeft,
//                     child: TabBar(
//                       isScrollable: true,
//                       labelPadding: EdgeInsets.only(right: 20, left: 20),
//                       indicator: CircleTabIndicator(
//                           color: AppColors.lightActiveIconColor, radius: 4),
//                       controller: controller.tabController,
//                       labelColor: AppColors.unActiveIconColor,
//                       unselectedLabelColor: Colors.grey,
//                       tabs: [
//                         Tab(
//                           text: 'dispatchFile',
//                         ),
//                         Tab(
//                           text: 'Files',
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 598.h,
//                   width: double.infinity,
//                   child: TabBarView(
//                     controller: controller.tabController,
//                     children: [
//                       dispatchFileForm(),
//                       FileList()
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
