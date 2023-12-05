
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: Colors.blueGrey, // Use a more appealing background color
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Center(
                  child: Text(
                    "Welcome back",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 28,
                        color: Colors.white, // Change the color
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Login to your account",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Change the color
                    ),
                  )
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
                    child: Text(
                      'Forgot password',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Obx(
                          () => elevatedButton(
                            bgColor: Colors.white,
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
                        const Text("Don't have an account?",
                        ),
                        TextButton(
                          onPressed: () {
                            _formKey.currentState?.reset();
                            Get.toNamed(RouteNames.signupview);
                          },
                          child: Text(
                            "SignUp",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.white, // Change the color
                              )
                            ),
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


// import 'package:amc_management/res/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../res/components/SessionViewComponents/custom_tetxField.dart';
// import '../../../res/components/SessionViewComponents/elevated_button.dart';
// import '../../../utils/custom_Utils.dart';
// import '../../../utils/routes/routes_name.dart';
// import 'controller.dart';
// class LoginView extends GetView<LoginController> {
//   LoginView({super.key});
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height * 1;
//     return Scaffold(
//         backgroundColor: AppColors.scaffoldBgColour,
//         body: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 150,
//                   ),
//                   Center(
//                     child: Text(
//                       "Welcome back",
//                       style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//                         color: AppColors.buttonColour
//                       ),
//
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Login to your account",
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   const SizedBox(
//                     height: 60,
//                   ),
//                   ReuseField(
//                       myController: controller.state.emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       focusNode: controller.state.Emailfocousnode,
//                       lableText: "Email",
//                       prefixIcon: Icon(Icons.email_outlined),
//                       onFiledSubmittedValue: (value) {
//                         ReuseableUtils.fieldfocous(
//                             context,
//                             controller.state.Emailfocousnode,
//                             controller.state.Passwordfocusnode);
//                       },
//                       obsecureText: false,
//                       onvalidator: (value) {
//                         return value.isEmpty ? 'Please Enter Email.' : null;
//                       }),
//                   const SizedBox(height: 15),
//                   ReuseField(
//                       myController: controller.state.passwordController,
//                       focusNode: controller.state.Passwordfocusnode,
//                       keyboardType: TextInputType.emailAddress,
//                       lableText: "Password",
//                        prefixIcon: Icon(Icons.password_outlined),
//                       onFiledSubmittedValue: (value) {
//                         },
//                       obsecureText: false,
//                       onvalidator: (value) {
//                         return value.isEmpty ? 'Please Enter Password.' : null;
//                       }),
//                   SizedBox(height: 10.h,),
//                   InkWell(
//                     onTap: () {
//                       Get.toNamed(RouteNames.forgotview);
//                     },
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         'Forgot password',
//                         style: Theme.of(context).textTheme.headline2!.copyWith(
//                             fontSize: 15,
//                             // decoration: TextDecoration.underline
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Column(
//                     children: [
//                       Obx(() => elevatedButton(
//                           tittle: 'Login',
//                           loading: controller.state.loading.value,
//                           onpress:(){
//                             if (_formKey.currentState!.validate()) {
//                               if (controller.state.emailController.text.trim() ==
//                                   "admin@admin.com" &&
//                                   controller.state.passwordController.text.trim() ==
//                                       "admin@123") {
//                                 controller.setLoading(true);
//                                 Get.offAllNamed(RouteNames.homeview)!.then((value){
//                                   controller.setLoading(false);
//                                   controller.state.passwordController.clear();
//                                   controller.state.emailController.clear();
//                                 });
//
//                               } else {
//                                 controller.LogIn(
//                                     context,
//                                     controller.state.emailController.text.trim(),
//                                     controller.state.passwordController.text.trim());
//                               }
//                             }
//
//                           })),
//                       SizedBox(height: 5.h,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Don't have an account?"),
//                           TextButton(
//                               onPressed: (){
//                             _formKey.currentState?.reset();
//                             Get.toNamed(RouteNames.signupview);
//                           }, child: Text("SignUp",style: TextStyle(
//                             color: AppColors.buttonColour
//                           ),)),
//                         ],
//                       )
//
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
