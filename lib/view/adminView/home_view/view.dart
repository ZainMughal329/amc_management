import 'package:amc_management/res/colors.dart';
import 'package:amc_management/utils/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
              height: 170.h,
              color: AppColors.sessionPageBgColor,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
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
                    top: 73,
                    right: 10,
                    child:
                      InkWell(
                        onTap: (){
                          Get.offNamed(RouteNames.loginview);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Image.asset('assets/images/logout.png',height: 25,),
                        ),
                      )
                    // IconButton(
                    //   color: AppColors.sessionPageTextColor,
                    //   icon: Icon(Icons.login_outlined),
                    //   onPressed: () {
                    //      Get.offNamed(RouteNames.loginview);
                    //
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ),

      SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(top:100.h),
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
                    lottie: 'assets/animations/userList.json',
                    // icon: Icons.supervised_user_circle,
                  ),
                  SectionCard(
                    onpress: () {
                      Get.toNamed(RouteNames.receivedfileview);
                    },
                    title: "Received File",
                    lottie: 'assets/animations/Recievd.json',
                    // icon: Icons.add,
                  ),
                  SectionCard(
                    onpress: () {
                      Get.toNamed(RouteNames.dispatchview);
                    },
                    title: "Dispatch File",
                    lottie: 'assets/animations/dispatchFile.json',
                    // icon: Icons.call_split,
                  ),
                  // SizedBox(height: 5.h),
                  SectionCard(
                    title: 'Diary Num Register',
                    onpress: () {
                      Get.toNamed(RouteNames.diaryNumView);
                    },
                    lottie: 'assets/animations/addFile.json',
                    // icon: Icons.book_online_outlined,
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



