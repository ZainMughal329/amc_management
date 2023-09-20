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
      'imgPath' : 'https://img.freepik.com/premium-vector/social-avatar-stories-gradient-frame_41737-3.jpg?w=740',
      'Text' : 'profile',
       // 'onpress':Get.toNamed(RouteNames.profileview)
    },
    {
      'imgPath' : 'https://img.freepik.com/free-vector/follow-me-social-business-theme-design_24877-50426.jpg?w=740&t=st=1694962420~exp=1694963020~hmac=3bcb813c277b41e4d477889490adefb4e62e6a943b82ade5a14056d69a39c320',
      'Text' : 'Users',
       // 'onpress':Get.toNamed(RouteNames.userlistview)
    },
    {
      'imgPath' : 'https://img.freepik.com/free-vector/image-upload-concept-landing-page_23-2148299321.jpg?size=626&ext=jpg&ga=GA1.1.967020246.1694961618&semt=ais',

      'Text' : 'Add File',
       // 'onpress':Get.toNamed(RouteNames.addfileview)
    },
    {
      'imgPath' : 'https://img.freepik.com/free-vector/file-searching-concept-landing-page_52683-22221.jpg?w=740&t=st=1694962800~exp=1694963400~hmac=55198af86c73a4afb632a3ddb1bca763d6cee14d6887b442f2a3238ec1c11a61',
      'Text' : 'Dispatch File',
       // 'onpress':Get.toNamed(RouteNames.dispatchview)
    },
    {
      'imgPath' : 'https://img.freepik.com/free-vector/image-upload-concept-landing-page_52683-22685.jpg?w=740&t=st=1694962587~exp=1694963187~hmac=f35c81cd8c07513ef0ea834da183074d5c12c1591d86ecc8ebbbc5ae6c2e8242',
      'Text' : 'Send File',
       // 'onpress':Get.toNamed(RouteNames.scanImage)
    },
  ];



}