import 'package:amc_management/res/components/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/userModel/user_model.dart';
import '../../../res/colors.dart';
import '../../../res/components/custom_tetxField.dart';
import '../../../utils/custom_Utils.dart';
import '../../../utils/routes/routes_name.dart';
import 'index.dart';
class SignUpView extends GetView<SignupController> {
  SignUpView({super.key});
  Widget dropDownList(){
    return Obx(()=> Expanded(
      flex: 0,
      child: DropdownButton(
        iconEnabledColor: AppColors.lightActiveIconColor,
        dropdownColor: AppColors.lightBgColor,
        style: TextStyle(color: AppColors.lightActiveIconColor),
        iconSize: 40.0.h,
        hint: controller.state.deptName.value==""?
        Text("selectDept",
          style: TextStyle(color: AppColors.titleTextColor),
        ):Text(
          controller.state.deptName.value,
          style: TextStyle(color: AppColors.subtitleTextColor),
        ),
        // value: controller.state.deptName.value,
        onChanged: (String? value){
          controller.state.deptName.value = value!;
        },
        items: [
          DropdownMenuItem(
            value: 'Principle',
            child: Text('Principle'),
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
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body:Form(
          key: _formkey,
          child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Text(
                  "Register",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Create your account",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 40),
                ReuseField(
                    myController: controller.state.usernamecontroller,
                    focusNode: controller.state.usernamefocousnode,
                    lableText: 'Username',
                    prefixIcon: Icon(Icons.person_outlined),
                    onFiledSubmittedValue: (value){
                      ReuseableUtils.fieldfocous(context, controller.state.usernamefocousnode, controller.state.Emailfocousnode);
                    },
                    keyboardType: TextInputType.name,
                    obsecureText: false,
                    onvalidator:(value){
                      return value.isEmpty?'enter your name ':null;
                    }
                ),
                const SizedBox(height: 10),
                ReuseField(
                    myController: controller.state.emailcontroller,
                    focusNode: controller.state.Emailfocousnode,
                    lableText: 'Email',
                    prefixIcon:Icon( Icons.email_outlined),
                    onFiledSubmittedValue: (value){
                      ReuseableUtils.fieldfocous(context,controller.state. Emailfocousnode, controller.state.Passwordfocusnode);
                    },
                    keyboardType: TextInputType.emailAddress,
                    obsecureText: false,
                    onvalidator:( value){
                      if (value == null || value.isEmpty) {
                        return "Please enter email.";
                      } else if (!(value.contains('@') & value.contains('.'))) {
                        return "Invalid email.";
                      }
                      return null;
                    }
                ),
                const SizedBox(height: 10),
                ReuseField(
                    myController: controller.state.passwordcontroller,
                    focusNode: controller.state.Passwordfocusnode,
                    lableText: 'Password',
                    prefixIcon: Icon(Icons.password_outlined),
                    suffixIcon: Icons.visibility_off,
                    onFiledSubmittedValue: (value){
                    },
                    keyboardType: TextInputType.emailAddress,
                    obsecureText: true,
                    onvalidator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password.";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 character.";
                      }
                      return null;
                    }
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select'),
                    dropDownList()

                  ],
                ),
                elevatedButton(tittle: 'Register',
                    loading: controller.state.loading.value,
                    onpress: (){
                  final user = UserModel(
                      dept: controller.state.deptName.toString().trim(),
                      email: controller.state.emailcontroller.text.trim(),
                      profile: '',
                      username:
                      controller.state.usernamecontroller.text.trim(),
                      password:
                      controller.state.passwordcontroller.text.trim());
                  controller.storeUser(user , context,controller.state.emailcontroller.text.trim(),
                      controller.state.passwordcontroller.text.trim(),
                      controller.state.deptName.toString().trim()
                  );

                }),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text("Don't have an account?"),
              TextButton(onPressed: (){
                _formkey.currentState?.reset();
                Get.toNamed(RouteNames.loginview);
              }, child:const Text("Login") )]),


              ],
            ),
          ),

          )),
    );
  }
}
