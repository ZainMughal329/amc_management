



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.isLogin();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Image(image: NetworkImage('https://cdn.highradius.com/wp-content/uploads/2023/07/inapp-d-1.png'))
              ),
            )
          ],
        ),
      ),
    );();
  }
}
