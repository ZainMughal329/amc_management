
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
            // controller.state.auth.signOut().then((value){
            //   //here we logout user and clear its ud
            //   //when they open app again then they have to go on login screen and login again
            //   SessionController().userid='';
            //   Navigator.pushNamed(context, RouteNames.loginview);
            // }).onError((error, stackTrace){
            //   Get.snackbar('Error', error.toString());
            // });
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
          children: List.generate(5, (index) => ReuseContainer(
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



// Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ReuseContainer(
//                       onpress: (){
//                          Get.toNamed(RouteNames.profileview);
//                       },
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image(
//                                 width: 170,
//                                 fit: BoxFit.fill,
//                                 image: NetworkImage(
//                                     "https://img.freepik.com/premium-vector/social-avatar-stories-gradient-frame_41737-3.jpg?w=740")),
//
//                             Text(
//                               'Profile',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                   // ReuseContainer(child: Text("scan image"), onpress: (){
//                   //   Get.toNamed(RouteNames.scanImage);
//                   // }),
//                   ReuseContainer(
//                       onpress: (){
//                         Get.toNamed(RouteNames.userlistview);
//                       },
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image(
//                                 width: 170,
//                                 fit: BoxFit.fill,
//                                 image: NetworkImage(
//                                     "https://img.freepik.com/free-vector/follow-me-social-business-theme-design_24877-50426.jpg?w=740&t=st=1694962420~exp=1694963020~hmac=3bcb813c277b41e4d477889490adefb4e62e6a943b82ade5a14056d69a39c320")),
//
//                             Text(
//                               'Users',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ReuseContainer(
//                       onpress: (){
//                         Get.toNamed(RouteNames.addfileview);
//                       },
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image(
//                                 width: 170,
//                                 fit: BoxFit.fill,
//                                 image: NetworkImage(
//                                     "https://img.freepik.com/free-vector/image-upload-concept-landing-page_23-2148299321.jpg?size=626&ext=jpg&ga=GA1.1.967020246.1694961618&semt=ais")),
//
//                             Text(
//                               'AddFile',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                   ReuseContainer(
//                       onpress: (){
//
//                       },
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image(
//                                 width: 170,
//                                 fit: BoxFit.fill,
//                                 image: NetworkImage(
//                                     "https://img.freepik.com/free-vector/image-upload-concept-landing-page_52683-22685.jpg?w=740&t=st=1694962587~exp=1694963187~hmac=f35c81cd8c07513ef0ea834da183074d5c12c1591d86ecc8ebbbc5ae6c2e8242")),
//
//                             Text(
//                               'Send File',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ReuseContainer(
//                       onpress: (){
//                         Get.toNamed(RouteNames.dispatchview);
//                       },
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image(
//                                 width: 170,
//                                 fit: BoxFit.fill,
//                                 image: NetworkImage(
//                                     "https://img.freepik.com/free-vector/file-searching-concept-landing-page_52683-22221.jpg?w=740&t=st=1694962800~exp=1694963400~hmac=55198af86c73a4afb632a3ddb1bca763d6cee14d6887b442f2a3238ec1c11a61")),
//
//                             Text(
//                               'Dispatch File',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                   ReuseContainer(
//                       onpress: (){
//                       },
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image(
//                                 width: 170,
//                                 fit: BoxFit.fill,
//                                 image: NetworkImage(
//                                     "https://img.freepik.com/free-vector/transfer-files-concept-landing-page_23-2148314294.jpg?w=740&t=st=1694962852~exp=1694963452~hmac=d5d95540666224be956bbfa6da4869980be80ee9d0affca76465fb0e25c5f9cd")),
//
//                             Text(
//                               'File',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                 ],
//               ),
//             ],
//           )