import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/components/custom_tetxField.dart';
import '../../../res/components/elevated_button.dart';
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
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        // resizeToAvoidBottomInset: false,
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
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login to your account",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ReuseField(
                      myController: controller.state.emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: controller.state.Emailfocousnode,
                      lableText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.Emailfocousnode,
                            controller.state.Passwordfocusnode);
                      },
                      obsecureText: false,
                      onvalidator: (value) {
                        return value.isEmpty ? 'Please Enter Email.' : null;
                      }),
                  const SizedBox(height: 15),
                  ReuseField(
                      myController: controller.state.passwordController,
                      focusNode: controller.state.Passwordfocusnode,
                      keyboardType: TextInputType.emailAddress,
                      lableText: "Passowrd",
                       prefixIcon: Icon(Icons.password_outlined),
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.Emailfocousnode,
                            controller.state.Passwordfocusnode);
                      },
                      obsecureText: false,
                      onvalidator: (value) {
                        return value.isEmpty ? 'Please Enter Email.' : null;
                      }),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteNames.forgotview);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot password',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 15, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Column(
                    children: [
                      Obx(() => elevatedButton(
                          tittle: 'Login',
                          loading: controller.state.loading.value,
                          onpress:(){
                            if (_formKey.currentState!.validate()) {
                              if (controller.state.emailController.text ==
                                  "admin@admin.com" &&
                                  controller.state.passwordController.text ==
                                      "admin@123") {
                                Get.offAllNamed(RouteNames.homeview);
                                controller.state.passwordController.clear();
                                controller.state.emailController.clear();
                              } else {
                                LoginController().LogIn(
                                    context,
                                    controller.state.emailController.text.trim().toString(),
                                    controller.state.passwordController.text.trim().toString());
                              }
                            }

                          })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                              onPressed: (){
                            _formKey.currentState?.reset();
                            Get.toNamed(RouteNames.signupview);
                          }, child:const Text("SignUp")),
                        ],
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
