import 'package:amc_management/res/colors.dart';
import 'package:amc_management/utils/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../model/services/session_Controller.dart';
import '../../../res/components/adminViewComponents/custom_container.dart';
import '../../../res/components/adminViewComponents/homeViewComponents/sectionCard.dart';
import '../../../utils/routes/routes_name.dart';
import '../../scanimages/view.dart';
import 'controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      Stack(
        children: [
          Container(
            height: 100.h,
            color: Colors.white, // Top color
          ),
          ClipPath(
            clipper: CustomCurveClipper(),
            child: Container(
              height: 150.h,
              color: AppColors.sessionPageBgColor,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/images/AMC DOC.png",
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 1,
                    child: IconButton(
                      color: AppColors.sessionPageTextColor,
                      icon: Icon(Icons.login_outlined),
                      onPressed: () {
                         Get.offNamed(RouteNames.loginview);

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),


      SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  SizedBox(height: 30.h),
                  SectionCard(
                    onpress: () {
                      Get.toNamed(RouteNames.userlistview);
                    },
                    title: "Users",
                    icon: Icons.supervised_user_circle,
                  ),
                  // SizedBox(height: 15.h),
                  // SectionCard(
                  //   onpress: () {
                  //     Get.to(() => DastakFoodApp());
                  //   },
                  //   title: "Send File",
                  //   icon: Icons.send,
                  // ),
                  SizedBox(height: 15.h),
                  SectionCard(
                    onpress: () {
                      Get.toNamed(RouteNames.receivedfileview);
                    },
                    title: "Received File",
                    icon: Icons.add,
                  ),
                  SizedBox(height: 15.h),

                  SectionCard(
                    onpress: () {
                      Get.toNamed(RouteNames.dispatchview);
                    },
                    title: "Dispatch File",
                    icon: Icons.call_split,
                  ),
                  SizedBox(height: 15.h),
                  SectionCard(
                    title: 'Diary Num Register',
                    onpress: () {
                      Get.toNamed(RouteNames.diaryNumView);
                    },
                    icon: Icons.book_online_outlined,
                  ),
                ],
              ),
            ),
          ),





        ],
      ),
    );
  }
}


class CustomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30); // Move to the bottom-left
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 30); // Curve
    path.lineTo(size.width, 0); // Move to the top-right
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



