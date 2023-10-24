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
      'imgPath' : 'https://img.freepik.com/premium-photo/3d-image-profile-isolated-white-background_598925-626.jpg?w=740',
      'Text' : 'profile',

    },
    {
      'imgPath' : Image(image: AssetImage('assets/users.jpg'),),
      'Text' : 'Users',
    },
    {
      'imgPath' : Image(image: AssetImage('assets/addFile.jpg'),),

      'Text' : 'Add File',

    },
    {
      'imgPath' : Image(image: AssetImage('assets/dispatchFile.jpg'),),
      'Text' : 'Dispatch File',
    },
    {
      'imgPath' : 'https://img.freepik.com/free-photo/rag-doll-with-bar-graph-green-pencil_1156-248.jpg?w=740&t=st=1695272973~exp=1695273573~hmac=2ca10243093368f480d118bb39d685651b30e6fe9f7d3166d0e8f9b1a3844457',
      'Text' : 'Send File',
    },

  ];

  final List<void Function()> pressButton = [
        () {
          Get.toNamed(RouteNames.profileview);
      print('1');
    },
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
        () {
          Get.toNamed(RouteNames.scanImage);
      print('5');
    },
  ];




}