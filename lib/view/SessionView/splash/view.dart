

import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/textWidget.dart';
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
      backgroundColor: AppColors.sessionPageBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                FadeInDown(
                  duration: Duration(milliseconds: 800),
                  child: Image(
                    image: AssetImage('assets/images/2 face.png'),
                    height: 250,
                    width: 250,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        duration: Duration(milliseconds: 800),
                        child: TextWidget(
                          title: 'HELLO',
                          fontSize: 32,
                          textColor: AppColors.sessionPageTextColor,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeIn(
                        duration: Duration(milliseconds: 1200),
                        child: TextWidget(
                          title: 'Welcome To Doc System',
                          fontSize: 20,
                          textColor: AppColors.tittleColour,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FadeIn extends StatelessWidget {
  final Duration duration;
  final Widget child;

  FadeIn({required this.duration, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}

class FadeInDown extends StatelessWidget {
  final Duration duration;
  final Widget child;

  FadeInDown({required this.duration, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -1, end: 0),
      duration: duration,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value * MediaQuery.of(context).size.height),
          child: child,
        );
      },
      child: child,
    );
  }
}

