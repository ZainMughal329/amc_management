import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/userModel/user_model.dart';
import '../../res/colors.dart';
import '../../res/components/custom_button.dart';
import '../../res/components/custom_tetxField.dart';
import '../../utils/custom_Utils.dart';
import '../../utils/routes/routes_name.dart';
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
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usernamecontroller = TextEditingController();
  final Emailfocousnode = FocusNode();
  final Passwordfocusnode = FocusNode();
  final usernamefocousnode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .05,
              ),
              Text(
                'Welcome to App',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: height * .01,
              ),
              Text(
                'Enter your email address \nto connect to your account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: height * .01,
              ),
              Padding(
                key: _formkey,
                padding:
                    EdgeInsets.only(bottom: height * .01, top: height * .06),
                child: Column(
                  children: [
                    // ..
                    ReuseField(
                      myController: controller.state.usernamecontroller,
                      // focusNode: usernamefocousnode,
                       onFiledSubmittedValue: (value){
                         ReuseableUtils.fieldfocous(context, controller.state.usernamefocousnode, controller.state.Emailfocousnode);
                       },
                      keyboardType: TextInputType.emailAddress,
                      obsecureText: false,
                      hint: 'enter your name',
                      onvalidator:(value){
                        return value.isEmpty?'enter your name ':"";
                      }
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    ReuseField(
                      myController: controller.state.emailcontroller,
                      // focusNode: Emailfocousnode,
                      onFiledSubmittedValue: (value){
                        ReuseableUtils.fieldfocous(context,controller.state. Emailfocousnode, controller.state.Passwordfocusnode);
                      },
                      keyboardType: TextInputType.emailAddress,
                      obsecureText: false,
                      hint: 'email',
                      onvalidator:(value){
                        return value.isEmpty?'enter email':"";
                      }
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    ReuseField(
                      myController: controller.state.passwordcontroller,
                      // focusNode: Passwordfocusnode,
                      onFiledSubmittedValue: (value){
                      },
                      keyboardType: TextInputType.emailAddress,
                      obsecureText: true,
                      hint: 'Password',
                      onvalidator: (value) {
                        return value.isEmpty?'enter password':null;
                      }
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select'),
                        dropDownList()

                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ReuseButton(
                  tittle: 'SignUp',
                  onpress: () {
                    print('inside on press');
                    final user = UserModel(
                      dept: controller.state.deptName.toString().trim(),
                        // id: controller.auth.currentUser!.uid.toString(),
                      //   id: SessionController().userid.toString(),
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
                    // controller.signUpUser(
                    //     controller.state.emailcontroller.text.trim(),
                    //     controller.state.passwordcontroller.text.trim());
                    print('Form Validate');
                  }),
              SizedBox(
                height: height * .03,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteNames.loginview);
                },
                child: Text.rich(
                  TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
