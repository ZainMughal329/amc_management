import 'package:amc_management/res/components/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/colors.dart';
import '../../../res/components/SessionViewComponents/custom_tetxField.dart';
import '../../../res/components/SessionViewComponents/elevated_button.dart';
import '../../../res/components/adminViewComponents/custom_button.dart';
import 'index.dart';

class ForgotView extends GetView<ForgotController> {
  const ForgotView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80.h,
              ),
              TextWidget(
                title: 'Forgot Password',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                textColor: AppColors.sessionPageTextColor,

              ),
              SizedBox(
                height: height * .02,
              ),
              TextWidget(
                title: 'Enter your email address to recover your password',
                textAlign: TextAlign.center,
                fontSize: 14,
                textColor: AppColors.tittleColour,

              ),
              SizedBox(
                height: height * .02,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: height * .01,
                    top: height * .06,
                  ),
                  child: Column(
                    children: [
                      ReuseField(
                        myController: controller.state.emailcontroller,
                        focusNode: controller.state.Emailfocousnode,
                        onFiledSubmittedValue: (value) {},
                        keyboardType: TextInputType.emailAddress,
                        obsecureText: false,
                        lableText: 'Enter your Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        onvalidator: (value) {
                          return value.isEmpty ? 'Enter your email' : null;
                        },
                      //   TextStyle(
                        //                         fontSize: 18,
                        //                         color: Colors.white,
                        //                       ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
          Obx(

                      () => controller.state.loading.value ==false? elevatedButton(
                          bgColor: AppColors.sessionPageButtonColor,
                          tittle: 'Recover', onpress: (){
                if(_formKey.currentState!.validate()){
                  controller.forgotPassword(context, controller.state.emailcontroller.text.trim());
                }
              }):Center(
                child:CircularProgressIndicator(
                  color: AppColors.buttonColour,
                ),
              )),
              ],
          ),
        ),
      ),
    );
  }
}

