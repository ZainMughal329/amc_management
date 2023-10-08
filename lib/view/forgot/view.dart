import 'package:amc_management/res/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/components/custom_tetxField.dart';
import 'index.dart';
class Forgotview extends GetView<ForgotController> {
  const Forgotview({super.key});
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
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
                height: height * .01,
              ),
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: height * .01,
              ),
              Text(
                'Enter your email address \nto recover your password',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
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
                            // focusNode: controller.state.Emailfocousnode,
                             onFiledSubmittedValue: (value) {},
                            keyboardType: TextInputType.emailAddress,
                            obsecureText: false,
                            hint: 'email',
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
                height: 40,
              ),
              ReuseButton(tittle: 'Recover', onpress: (){
                if(_formkey.currentState!.validate()){
                  controller.forgotPassword(context, controller.state.emailcontroller.text.trim());
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
