


import 'package:amc_management/view/userView/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/userModel/user_model.dart';
import '../../res/colors.dart';
import '../../res/components/bigAppText.dart';
import '../../res/components/userApprovalPage.dart';
class userView extends GetView<userViewController> {
  String deptName;
   userView({super.key,required this.deptName});
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
                backgroundColor: AppColors.primaryBackground,
                body: SafeArea(
                  child:
                  SingleChildScrollView(
                    child:   StreamBuilder<QuerySnapshot>(
                        stream:controller.state.firestoreRef.where( 'dept',
                            isEqualTo:deptName) ,
                        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
                          return Text('wahba');
                        }) ,
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


//Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.only(
//                             left: 20,
//                             top: 20,
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(child: Container()),
//                               Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   // color: AppColors.iconsColor,
//                                   border: Border.all(
//                                     color: AppColors.lightActiveIconColor,
//                                     width: 2.0,
//                                   ),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(50),
//                                   child: user.profile.toString()==''?
//                                   Icon(
//                                     Icons.person_outline,
//                                     size: 30,
//                                     color: AppColors
//                                         .lightActiveIconColor,
//                                   ):Image(image: NetworkImage(user.profile.toString()),
//                                     fit: BoxFit.cover,
//                                   )
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               )
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 5, right: 5),
//                           child: Center(
//                             child: BigAppText(
//                                 text: user.username
//                                     .toString()
//                                     .capitalizeFirst
//                                     .toString(),
//                                 size: 30),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                       ],
//                     )