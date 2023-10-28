



import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.isLogin();
    return Scaffold(
      backgroundColor:  Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70,),
              const Image(
                image: AssetImage('assets/images/2 face.png'),
              ),
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0,bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "HELLO",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      Text(
                        "Welcome To Doc System",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      // SizedBox(height: 10,),
                      // Column(
                      //   children: [
                      //     ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         minimumSize: const Size.fromHeight(50),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //       ),
                      //       onPressed: (){
                      //         Get.offAllNamed(RouteNames.loginview);
                      //
                      //       },
                      //       child: const Text("Login"),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 10,),
                      // Column(
                      //   children: [
                      //     ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         minimumSize: const Size.fromHeight(50),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //       ),
                      //       onPressed: (){
                      //         Get.offAllNamed(RouteNames.signupview);
                      //       },
                      //       child: const Text("SignUp"),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      );
  }
}
