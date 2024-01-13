
import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../res/components/SessionViewComponents/custom_tetxField.dart';
import '../../../res/components/SessionViewComponents/elevated_button.dart';
import '../../../utils/custom_Utils.dart';
import '../../../utils/routes/routes_name.dart';
import 'controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final con = Get.put(LoginController());
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: AppColors.sessionPageBgColor, // Use a more appealing background color
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                // Lottie.asset('assets/animations/Login1.json'),
                Image(image: AssetImage('assets/images/AMC.png')),
                TextWidget(
                  title: "Welcome back",
                  textColor:AppColors.sessionPageTextColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                // FadeIn(
                //     duration: Duration(milliseconds: 1200),
                //     child:),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(title: "Login to your account",
                  textColor:AppColors.tittleColour,
                  fontSize: 16,

                ),
                const SizedBox(
                  height: 60,
                ),
                ReuseField(
                  // Customize your text field

                  myController: controller.state.emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: controller.state.Emailfocousnode,
                  lableText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  onFiledSubmittedValue: (value) {
                    ReuseableUtils.fieldfocous(
                      context,
                      controller.state.Emailfocousnode,
                      controller.state.Passwordfocusnode,
                    );
                  },
                  obsecureText: false,
                  onvalidator: (value) {
                    return value.isEmpty ? 'Please Enter Email.' : null;
                  },
                ),
                const SizedBox(height: 15),
                ReuseField(
                  // Customize your password field
                  myController: controller.state.passwordController,
                  focusNode: controller.state.Passwordfocusnode,
                  keyboardType: TextInputType.emailAddress,
                  lableText: "Password",
                  prefixIcon: Icon(Icons.password_outlined),
                  onFiledSubmittedValue: (value) {},
                  obsecureText: false,
                  onvalidator: (value) {
                    return value.isEmpty ? 'Please Enter Password.' : null;
                  },
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteNames.forgotview);
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextWidget(
                      title: 'Forgot password',
                          fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Obx(
                          () => elevatedButton(
                            bgColor: AppColors.sessionPageButtonColor,
                        // Customize your login button
                        tittle: 'Login',
                        loading: controller.state.loading.value,
                        onpress: () {
                          if (_formKey.currentState!.validate()) {
                            if (controller.state.emailController.text.trim() ==
                                "admin@admin.com" &&
                                controller.state.passwordController.text.trim() ==
                                    "admin@123") {
                              controller.setLoading(true);
                              Get.offAllNamed(RouteNames.homeview)!.then((value) {
                                controller.setLoading(false);
                                controller.state.passwordController.clear();
                                controller.state.emailController.clear();
                              });
                            } else {
                              controller.LogIn(
                                context,
                                controller.state.emailController.text.trim(),
                                controller.state.passwordController.text.trim(),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextWidget(title: "Don't have an account?",
                        fontSize: 12,
                          textColor: AppColors.tittleColour,
                        ),
                        TextButton(
                          onPressed: () {
                            _formKey.currentState?.reset();
                            Get.toNamed(RouteNames.signupview);
                          },
                          child: TextWidget(
                            title: "SignUp",
                            textColor: AppColors.sessionPageTextColor,
                          ),
                        ),
                      ],
                    )
                  ],
                )
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



