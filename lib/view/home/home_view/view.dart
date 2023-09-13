
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
            controller.state.auth.signOut().then((value){
              //here we logout user and clear its ud
              //when they open app again then they have to go on login screen and login again
              SessionController().userid='';
              Navigator.pushNamed(context, RouteNames.loginview);
            }).onError((error, stackTrace){
              Get.snackbar('Error', error.toString());
            });
          }, icon: Icon(Icons.login_outlined))
        ],
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReuseContainer(
                      onpress: (){
                        // Get.toNamed(RouteNames.profileview);
                      },
                      child: Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  ReuseContainer(child: Text("scan image"), onpress: (){
                    Get.toNamed(RouteNames.scanImage);
                  }),
                  ReuseContainer(
                      onpress: (){
                        Get.toNamed(RouteNames.userlistview);
                      },
                      child: Center(
                        child: Text(
                          'Users',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReuseContainer(
                      onpress: (){
                        Get.toNamed(RouteNames.addfileview);
                      },
                      child: Center(
                        child: Text(
                          'Add File',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  ReuseContainer(
                      onpress: (){

                      },
                      child: Center(
                        child: Text(
                          'Send File',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReuseContainer(
                      onpress: (){
                        Get.toNamed(RouteNames.dispatchview);
                      },
                      child: Center(
                        child: Text(
                          'Dispatch File',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  ReuseContainer(
                      onpress: (){

                      },
                      child: Center(
                        child: Text(
                          'Files',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
