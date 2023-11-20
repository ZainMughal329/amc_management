
import 'package:amc_management/res/colors.dart';
import 'package:amc_management/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../model/services/session_Controller.dart';
import '../../../res/components/adminViewComponents/custom_container.dart';
import '../../../utils/routes/routes_name.dart';
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
              // SectionCard(
              //   onpress: (){
              //     // Get.to(ListOfFileView());
              //   },
              //   title: "Send File",
              //   icon: Icons.send,
              // ),
              SectionCard(
                onpress:(){
                  Get.toNamed(RouteNames.addfileview);
                  ;
                },
                title: "Add File",
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

            ],
          ),
        ),
      )
    );
  }
}
class SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onpress;

  SectionCard({
    required this.title,
    required this.onpress,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.gradientStart, // Adjust gradient start color
              AppColors.gradientEnd,   // Adjust gradient end color
            ],
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 64.0, color: AppColors.admincardiconColor),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(fontSize: 24.0, color: AppColors.admincardtextColor),
            ),
          ],
        ),
      ),
    );
  }
}


// class SectionCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final VoidCallback onpress;
//
//   SectionCard({
//     required this.title,
//     required this.onpress,
//   required this.icon
// });
//
// @override
// Widget build(BuildContext context) {
//   return InkWell(
//     onTap: onpress,
//
//     // transitionsBuilder: (context, animation, secondaryAnimation, child) {
//     //   const begin = Offset(1.0, 0.0);
//     //   const end = Offset.zero;
//     //   const curve = Curves.easeInOut;
//     //   var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//     //   var offsetAnimation = animation.drive(tween);
//     //   return SlideTransition(position: offsetAnimation, child: child);
//     // },
//     child: Container(
//       margin: EdgeInsets.all(16.0),
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: AppColors.elevatedButtonColour,
//         borderRadius: BorderRadius.circular(10.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 3,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(icon, size: 64.0, color: Colors.white),
//           SizedBox(height: 10.0),
//           Text(
//             title,
//             style: TextStyle(fontSize: 24.0, color: Colors.white),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }


//GridView.count(
//           crossAxisCount: 2,
//           childAspectRatio: 240 / 250,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           children: List.generate(4, (index) => ReuseContainer(
//             title: controller.appInfo[index]['Text'],
//             image: controller.appInfo[index]['imgPath'],
//             color: controller.gridColors[index],
//             onpress: controller.pressButton[index],
//           )),
//         )