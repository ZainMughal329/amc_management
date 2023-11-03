import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class HomeController extends GetxController{

  final state = HomeState();
  HomeController();
  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffB7DFF5),

  ];

  List<Map<String , dynamic>> appInfo = [

    {
      'imgPath' : 'assets/images/users.jpg',
      'Text' : 'Users',
    },
    {
      'imgPath' : 'assets/images/addFile.jpg',
      'Text' : 'Add File',

    },
    {
      'imgPath' : 'assets/images/dispatchFile.jpg',
      'Text' : 'Dispatch File',
    },
    {
      'imgPath' : 'assets/images/single.jpg',
      'Text' : 'Send File',
    },

  ];

  final List<void Function()> pressButton = [
    //     () {
    //       Get.toNamed(RouteNames.profileview);
    //   print('1');
    // },
        () {
      print('2');
      Get.toNamed(RouteNames.userlistview);

    },
        () {
          Get.toNamed(RouteNames.addfileview);
      print('3');
    },
        () {
          Get.toNamed(RouteNames.dispatchview);
      print('4');
    },
    //     () {
    // Get.to(ListOfFileView());
    //       // Get.toNamed(RouteNames.scanImage);
    //   print('5');
    // },
  ];




}