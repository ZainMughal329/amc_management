
import 'package:amc_management/res/colors.dart';
import 'package:amc_management/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../model/services/session_Controller.dart';
import '../../../res/components/adminViewComponents/custom_container.dart';
import '../../../res/components/adminViewComponents/homeViewComponents/sectionCard.dart';
import '../../../utils/routes/routes_name.dart';
import '../../scanimages/view.dart';
import 'index.dart';
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminhomebackgroundColor,
        // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'HomeView',
          style: TextStyle(fontWeight: FontWeight.bold,
          color: AppColors.buttonBgColor
          ),
        ),
        actions: [
           IconButton(onPressed: (){
             Get.offNamed(RouteNames.loginview);
          }, icon: Icon(Icons.login_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(height: 30.h,),
              SectionCard(
                onpress: (){
                  Get.toNamed(RouteNames.userlistview);
                },
                title: "Users",
                icon: Icons.supervised_user_circle,
              ),
              SizedBox(height: 15.h,),
              SectionCard(
                onpress: (){
                  Get.to(()=>DastakFoodApp());
                },
                title: "Send File",
                icon: Icons.send,
              ),
              SectionCard(
                onpress:(){
                  Get.toNamed(RouteNames.receivedfileview);
                },
                title: "Received File",
                icon: Icons.add,
              ),
              SizedBox(height: 15.h,),

              SectionCard(
                onpress: (){
                  Get.toNamed(RouteNames.dispatchview);
                },
                title: "Dispatch File",
                icon: Icons.call_split,
              ),
              SizedBox(height: 15.h,),
              SectionCard(title: 'Diary Num Register', onpress: (){
                Get.toNamed(RouteNames.diaryNumView);
              }, icon: Icons.book_online_outlined)
            ],
          ),
        ),
      )
    );
  }
}



