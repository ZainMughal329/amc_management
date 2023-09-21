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
      'imgPath' : 'https://img.freepik.com/free-photo/man-relaxing-bench_1048-1608.jpg?w=360&t=st=1695272687~exp=1695273287~hmac=c225122efcc1fec77db5775aec47291af2d7d28050cedfd313677a9afaf87e35',
      'Text' : 'Users',
    },
    {
      'imgPath' : 'https://img.freepik.com/free-photo/rag-doll-with-three-cabinets-red-top_1156-270.jpg?w=740&t=st=1695272873~exp=1695273473~hmac=f7bcc9a605c3cdc104dc1043ba201e0a17b13fa4392cc7edc5ba9d6fa0d1f475',

      'Text' : 'Add File',

    },
    {
      'imgPath' : 'https://img.freepik.com/free-photo/rag-dolls-working-with-boxes_1156-226.jpg?w=740&t=st=1695272921~exp=1695273521~hmac=ad679d8fa8d8450aa4ae374a6f7ef280c4b4cff9f215d6129699e12d880b318b',
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

// https://img.freepik.com/free-vector/image-upload-concept-landing-page_52683-22685.jpg?w=740&t=st=1694962587~exp=1694963187~hmac=f35c81cd8c07513ef0ea834da183074d5c12c1591d86ecc8ebbbc5ae6c2e8242
// https://img.freepik.com/free-vector/file-searching-concept-landing-page_52683-22221.jpg?w=740&t=st=1694962800~exp=1694963400~hmac=55198af86c73a4afb632a3ddb1bca763d6cee14d6887b442f2a3238ec1c11a61
// https://img.freepik.com/free-vector/follow-me-social-business-theme-design_24877-50426.jpg?w=740&t=st=1694962420~exp=1694963020~hmac=3bcb813c277b41e4d477889490adefb4e62e6a943b82ade5a14056d69a39c320
//https://img.freepik.com/premium-vector/social-avatar-stories-gradient-frame_41737-3.jpg?w=740
//https://img.freepik.com/free-vector/image-upload-concept-landing-page_23-2148299321.jpg?size=626&ext=jpg&ga=GA1.1.967020246.1694961618&semt=ais