import 'package:amc_management/res/colors.dart';
import 'package:amc_management/view/home/addFile/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../res/components/tab_bar_setting.dart';
import 'components/addFileDataList.dart';
import 'components/addFileForm.dart';
class addFileView extends GetView<addFileController> {
  const addFileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
          child:Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: AppColors.lightActiveIconColor,
                      child: IconButton(
                          onPressed: (){
                            Get.back();
                          }, icon: Icon(Icons.arrow_back,
                        color: Colors.white,
                      )),
                    )),
              ),
              SizedBox(height: 15,),
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
                        text: 'UploadFile',
                      ),
                      Tab(
                        text: 'UploadedFiles',
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
                 Container(height: 598,
                width: double.infinity,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      addFileForm(),
                      addFileDataList(),
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
