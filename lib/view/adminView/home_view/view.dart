
import 'package:amc_management/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/services/session_Controller.dart';
import '../../../res/components/custom_container.dart';
import '../../../utils/routes/routes_name.dart';
import 'index.dart';
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'HomeView',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
           IconButton(onPressed: (){
             Get.offNamed(RouteNames.loginview);
          }, icon: Icon(Icons.login_outlined))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 250,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(4, (index) => ReuseContainer(
            title: controller.appInfo[index]['Text'],
            image: controller.appInfo[index]['imgPath'],
            color: controller.gridColors[index],
            onpress: controller.pressButton[index],
          )),
        ),
      )
    );
  }
}
