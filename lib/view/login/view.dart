import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/components/custom_button.dart';
import '../../res/components/custom_tetxField.dart';
import '../../utils/routes/routes_name.dart';
import 'controller.dart';
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height*1;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height*.05,),
              Text('Welcome to App',style: Theme.of(context).textTheme.displaySmall,),
              SizedBox(height:height*.01 ,),
              Text('Enter your email address \nto connect to your account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,),
              SizedBox(height: height*.01,),
              Form(
                  key:_formKey,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: height*.01,top: height*.06),
                    child: Column(
                      children: [
                        ReuseField(myController: controller.state.emailController,
                          focusNode:controller.state.emailfocous,
                          // onFiledSubmittedValue: (value){
                          // },
                          keyboardType: TextInputType.emailAddress,
                          obsecureText: false,
                          hint: 'email',
                          onvalidator: (value){
                          },
                          // onvalidator:(value){
                          //   return value.isEmpty?'enter email':null;
                          // }
                        ),
                        SizedBox(height: height*.01,),
                        ReuseField(myController: controller.state.passwordController,
                          focusNode:controller.state.passwordfocous,
                          // onFiledSubmittedValue: (value){
                          // },
                          keyboardType: TextInputType.emailAddress,
                          obsecureText: false,
                          hint: 'password',
                          onvalidator: (value){

                          },
                          // onvalidator:(value){
                          //   return value.isEmpty?'enter password':null;
                          // }
                        ),
                      ],
                    ),)),
              InkWell(
                onTap: (){
                  Get.toNamed(RouteNames.forgotview);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forgot password',
                    style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15,
                        decoration: TextDecoration.underline),),
                ),
              ),
              SizedBox(height: 40,),
              Obx(() => ReuseButton(tittle:'login',
                  loading: controller.state.loading.value,
                  onpress: (){
                    if(_formKey.currentState!.validate()){
                      LoginController().LogIn(context, controller.state.emailController.text, controller.state.passwordController.text);
                    }
                  }),),
              SizedBox(height: height*.03,),
              InkWell(
                onTap: (){
                  Get.toNamed(RouteNames.signupview);
                },
                child: Text.rich(
                    TextSpan(
                        text:"Don't have an account?",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 15),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 15,
                                decoration: TextDecoration.underline),
                          )
                        ]
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
