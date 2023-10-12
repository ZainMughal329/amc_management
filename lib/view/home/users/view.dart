import 'package:amc_management/res/components/tab_bar_setting.dart';
import 'package:amc_management/view/home/users/components/userList.dart';
import 'package:amc_management/view/home/users/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/colors.dart';
import 'components/userApproval.dart';
class userListView extends GetView<userController> {
  const userListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  isScrollable: true,
                  labelPadding:
                  EdgeInsets.only(right: 20,left: 20),
                  indicator: CircleTabIndicator(color: AppColors.lightActiveIconColor,radius: 4),
                  controller: controller.tabController,
                  labelColor: AppColors.buttonBgColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: 'Users',
                    ),
                    Tab(
                      text: 'Approvals',
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 590,
              width: double.infinity,
              child: TabBarView(
                  controller: controller.tabController,
                  children:[
                    userList(),
                    userApproval()
              ]),
            )
          ],
        ),
      )
    );
  }
}


