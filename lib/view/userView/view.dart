


import 'package:amc_management/view/userView/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/userModel/user_model.dart';
import '../../res/colors.dart';
import '../../res/components/bigAppText.dart';
import '../../res/components/userApprovalPage.dart';
class userView extends GetView<userViewController> {
  const userView({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      body:SafeArea(
        child: FutureBuilder(future: controller.getUsersData(),

            builder: (context,snapshot){

          if(snapshot.hasData){
            UserModel user =snapshot.data as UserModel;
            if(user.status=='true'){
              return Scaffold(
                key: _scaffoldKey,
                // add profile in drawer here
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.primaryMaterialColor,
                body: SafeArea(
                  child:
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // color: AppColors.iconsColor,
                                  border: Border.all(
                                    color: AppColors.primaryIconColor,
                                    width: 2.0,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: user.profile.toString()==''?
                                  Icon(
                                    Icons.person_outline,
                                    size: 30,
                                    color: AppColors
                                        .primaryIconColor,
                                  ):Image(image: NetworkImage(user.profile.toString()),
                                    fit: BoxFit.cover,
                                  )
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Center(
                            child: BigAppText(
                                text: user.username
                                    .toString()
                                    .capitalizeFirst
                                    .toString(),
                                size: 30),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),

              );
            }else{
              return userApprovalPage();
            }

          }else{
            return Scaffold(
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator()
                ],
              ),
            );
          }
            }
            ),
      )
    );
  }
}
