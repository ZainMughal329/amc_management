
import 'package:amc_management/res/colors.dart';
import 'package:amc_management/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/services/session_Controller.dart';
import '../../../res/components/adminViewComponents/custom_container.dart';
import '../../../utils/routes/routes_name.dart';
import '../listofImages/view.dart';
import 'index.dart';
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
              SectionCard(
                onpress: (){
                  // Get.to(ListOfFileView());
                },
                title: "Send File",
                icon: Icons.send,
              ),
              SectionCard(
                onpress: (){
                  Get.toNamed(RouteNames.dispatchview);
                },
                title: "Dispatch File",
                icon: Icons.call_split,
              ),
              SectionCard(
                onpress: (){
                  Get.toNamed(RouteNames.userlistview);
                },
                title: "Users",
                icon: Icons.supervised_user_circle,
              ),
              SectionCard(
                onpress:(){
                  Get.toNamed(RouteNames.addfileview);
                  ;
                },
                title: "Add File",
                icon: Icons.add,
              ),
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
  required this.icon
});

@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: onpress,

    // transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //   const begin = Offset(1.0, 0.0);
    //   const end = Offset.zero;
    //   const curve = Curves.easeInOut;
    //   var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    //   var offsetAnimation = animation.drive(tween);
    //   return SlideTransition(position: offsetAnimation, child: child);
    // },
    child: Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.elevatedButtonColour,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 64.0, color: Colors.white),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
}


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