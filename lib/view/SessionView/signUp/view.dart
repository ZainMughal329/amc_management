import 'package:amc_management/res/components/SessionViewComponents/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/userModel/user_model.dart';
import '../../../res/colors.dart';
import '../../../res/components/SessionViewComponents/custom_tetxField.dart';
import '../../../res/components/textWidget.dart';
import '../../../utils/custom_Utils.dart';
import '../../../utils/routes/routes_name.dart';
import 'index.dart';

class SignUpView extends GetView<SignupController> {
  SignUpView({super.key});

  Widget dropDownList() {
    return Obx(() => Expanded(
          flex: 0,
          child: DropdownButton(
            iconEnabledColor: AppColors.lightActiveIconColor,
            dropdownColor: AppColors.lightBgColor,
            style: TextStyle(color: AppColors.lightActiveIconColor),
            iconSize: 40.0.h,
            hint: controller.state.deptName.value == ""
                ? TextWidget(
                  title: "selectDept",
                    textColor: AppColors.titleTextColor,
                  )
                : TextWidget(
                    title: controller.state.deptName.value,
                    textColor: AppColors.sessionPageTextColor,
                  ),
            // value: controller.state.deptName.value,
            onChanged: (String? value) {
              controller.state.deptName.value = value!;
            },
            items: [
              DropdownMenuItem(
                value: 'Principle',
                child: Text('Principle'),
              ),
              DropdownMenuItem(
                value: 'Vice-Principle',
                child: Text('Vice-Principle'),
              ),
              DropdownMenuItem(
                value: 'Staff',
                child: Text('Staff'),
              ),
              DropdownMenuItem(
                value: 'IT',
                child: Text('IT'),
              ),
              DropdownMenuItem(
                value: 'English',
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: 'Math',
                child: Text('Math'),
              ),
              DropdownMenuItem(
                value: 'Physics',
                child: Text('Physics'),
              ),
              DropdownMenuItem(
                value: 'Economics',
                child: Text('Economics'),
              ),
              DropdownMenuItem(
                value: 'Biology',
                child: Text('Biology'),
              ),
              DropdownMenuItem(
                value: 'Urdu',
                child: Text('Urdu'),
              ),
              DropdownMenuItem(
                value: 'Chemistry',
                child: Text('Chemistry'),
              ),
            ],
          ),
        ));
  }

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      backgroundColor: AppColors.sessionPageBgColor,
      body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Image(image: AssetImage('assets/images/AMC.png')),
                  TextWidget(
                    title: 'Register',
                    fontSize: 28,
                    textColor: AppColors.sessionPageTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  TextWidget(
                    title: 'Create your account',
                    textColor: AppColors.tittleColour,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 40),
                  ReuseField(
                      myController: controller.state.usernamecontroller,
                      focusNode: controller.state.usernamefocousnode,
                      lableText: 'Username',
                      prefixIcon: Icon(Icons.person_outlined),
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.usernamefocousnode,
                            controller.state.Emailfocousnode);
                      },
                      keyboardType: TextInputType.name,
                      obsecureText: false,
                      onvalidator: (value) {
                        return value.isEmpty ? 'enter your name ' : null;
                      }),
                  const SizedBox(height: 10),
                  ReuseField(
                      myController: controller.state.emailcontroller,
                      focusNode: controller.state.Emailfocousnode,
                      lableText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      onFiledSubmittedValue: (value) {
                        ReuseableUtils.fieldfocous(
                            context,
                            controller.state.Emailfocousnode,
                            controller.state.Passwordfocusnode);
                      },
                      keyboardType: TextInputType.emailAddress,
                      obsecureText: false,
                      onvalidator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email.";
                        } else if (!(value.contains('@') &
                            value.contains('.'))) {
                          return "Invalid email.";
                        }
                        return null;
                      }),
                  const SizedBox(height: 10),
                  ReuseField(
                      myController: controller.state.passwordcontroller,
                      focusNode: controller.state.Passwordfocusnode,
                      lableText: 'Password',
                      prefixIcon: Icon(Icons.password_outlined),
                      suffixIcon: Icons.visibility_off,
                      onPressSufix: (){
                        controller.togglePasswordVisibility();

                      },
                      onFiledSubmittedValue: (value) {},
                      keyboardType: TextInputType.emailAddress,
                      obsecureText: true,
                      onvalidator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password.";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 character.";
                        }
                        return null;
                      }),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        title: 'Select',
                        textColor: AppColors.titleTextColor,
                      ),
                      dropDownList()
                    ],
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => controller.state.loading.value == false
                        ? elevatedButton(
                            bgColor: AppColors.sessionPageButtonColor,
                            tittle: 'Register',
                            // loading: controller.state.loading.value,
                            onpress: () {
                              final user = UserModel(
                                  dept: controller.state.deptName
                                      .toString()
                                      .trim(),
                                  email: controller.state.emailcontroller.text
                                      .trim(),
                                  profile: '',
                                  username: controller
                                      .state.usernamecontroller.text
                                      .trim(),
                                  password: controller
                                      .state.passwordcontroller.text
                                      .trim());
                              controller.storeUser(
                                  user,
                                  context,
                                  controller.state.emailcontroller.text.trim(),
                                  controller.state.passwordcontroller.text
                                      .trim(),
                                  controller.state.deptName.toString().trim());
                            },
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColour,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const TextWidget(
                      title: "Don't have an account?",
                      textColor: AppColors.tittleColour,
                      fontSize: 12,
                    ),
                    TextButton(
                        onPressed: () {
                          _formkey.currentState?.reset();
                          Get.toNamed(RouteNames.loginview);
                        },
                        child: TextWidget(
                          title: "Login",
                        ))
                  ]),
                ],
              ),
            ),
          )),
    );
  }
}
