import 'dart:io';
import 'package:amc_management/view/home/dispatchFile/components/disptachfileUploadForm.dart';
import 'package:intl/intl.dart';
import 'package:amc_management/model/dispatch_model/dispatch_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_button.dart';
import '../../../res/components/tab_bar_setting.dart';
import 'components/filesListViewbuilder.dart';
import 'index.dart';

class dispatchView extends GetView<dispatchController> {
  const dispatchView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryIconColor,
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
                  height: 15,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TabBar(
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(right: 20, left: 20),
                      indicator: CircleTabIndicator(
                          color: AppColors.primaryIconColor, radius: 4),
                      controller: controller.tabController,
                      labelColor: AppColors.lightGrayColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          text: 'dispatchFile',
                        ),
                        Tab(
                          text: 'Files',
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 598,
                  width: double.infinity,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      SingleChildScrollView(child: dispatchFileForm()),
                      FileList()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

