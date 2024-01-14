import 'package:amc_management/res/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../res/components/adminViewComponents/sharedComponents/tab_bar_setting.dart';
import '../receivedFileUploadForm/view.dart';
import '../receivedFilesList/view.dart';
import 'index.dart';
class receivedFileView extends GetView<receivedFileController> {
  const receivedFileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.filesBgColour,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child:Column(
              children: [
                SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundColor: AppColors.fileTabBarIconButtonColor,
                        child: IconButton(
                            onPressed: (){
                              Get.back();
                            }, icon: Icon(Icons.arrow_back,
                          color: Colors.white,
                        )),
                      )),
                ),
                SizedBox(height: 5.h,),
                Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TabBar(
                      isScrollable: true,
                      labelPadding:
                      EdgeInsets.only(right: 20,left: 20),
                      indicator: CircleTabIndicator(color: AppColors.lightActiveIconColor,radius: 4),
                      controller: controller.tabController,
                      labelColor: AppColors.unActiveIconColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          child: Text('UploadFile',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontWeight: FontWeight.bold,)
                      )
                          ),
                        ),
                        Tab(
                          child: Text('UploadedFiles',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(fontWeight: FontWeight.bold,)
                              )
                          ),

                        )
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 5.h,),
                Container(height: 598.h,
                  width: double.infinity,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      receivedFileForm(),
                      receivedFileDataList(),
                    ],
                  ),
                ),
              ],
            ) ,
          ),
        ),
      ),
    );
  }
}
