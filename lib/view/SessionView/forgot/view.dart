import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/SessionViewComponents/elevated_button.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/SessionViewComponents/custom_tetxField.dart';
import 'index.dart';
class Forgotview extends GetView<ForgotController> {
  const Forgotview({super.key});
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blueGrey, // Use a more appealing background color

      // backgroundColor: AppColors.scaffoldBgColour,
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
              Text(
                'Forgot Password',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              Text(
                'Enter your email address \nto recover your password',
                textAlign: TextAlign.center,
                style:GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Change the color
                  ),
                )

              ),
              SizedBox(
                height: height * .01,
              ),
              Form(
                  key: _formkey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: height * .01, top: height * .06),
                    child: Column(
                      children: [
                        ReuseField(
                            myController: controller.state.emailcontroller,
                             focusNode: controller.state.Emailfocousnode,
                             onFiledSubmittedValue: (value) {},
                            keyboardType: TextInputType.emailAddress,
                            obsecureText: false,
                            lableText: 'Enter you Email',
                            prefixIcon: Icon(Icons.password_outlined),
                             onvalidator: (value) {
                               return value.isEmpty ? 'enter email' : null;
                             }
                            ),
                        SizedBox(
                          height: height * .01,
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height:25,
              ),
              Obx(

                      () => controller.state.loading.value ==false? elevatedButton(
                          bgColor: Colors.white,
                          tittle: 'Recover', onpress: (){
                if(_formkey.currentState!.validate()){
                  controller.forgotPassword(context, controller.state.emailcontroller.text.trim());
                }
              }):Center(
                child:CircularProgressIndicator(
                  color: AppColors.buttonColour,
                ),
              ))

            ],
          ),
        ),
      ),
    );
  }
}
