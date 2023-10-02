

import 'package:amc_management/view/home/users/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/colors.dart';

class userApproval extends GetView<userController> {
  const userApproval({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: StreamBuilder<QuerySnapshot>(stream: controller.firestore,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        try{
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.docs.length !=0?
              ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Container(
                        height: 130,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrayColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.primaryTextTextColor.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrayColor,
                                  border: Border.all(
                                    color: AppColors.primaryTextTextColor,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: snapshot.data!.docs[index]['profile'].toString() == ''
                                      ? Icon(
                                    Icons.person_outline,
                                    size: 30,
                                    color: AppColors.primaryTextTextColor,
                                  )
                                      : Image(
                                    image: NetworkImage(
                                      snapshot.data!.docs[index]['profile'].toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(snapshot.data!.docs[index]['UserName'].toString()),
                              subtitle: Text(snapshot.data!.docs[index]['Email'].toString()),
                            ),
                            SizedBox(height: 20,),
                            snapshot.data!.docs[index]['status']
                                .toString() ==
                                'false'
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    controller.deleteUserData(
                                        snapshot.data!.docs[index].id
                                            .toString());
                                  },
                                  child: Text('Decline' , style: TextStyle(color: AppColors.primaryMaterialColor),),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    controller.updateUserData(
                                        snapshot.data!.docs[index].id
                                            .toString());
                                  },
                                  child: Text('Approve' , style: TextStyle(color: AppColors.iconBackgroundColor),),
                                ),
                              ],
                            )
                                : Container(
                              child: TextButton(
                                onPressed: () async {},
                                child: Text('Approved'),
                              ),
                            ),
                          ],
                        ),

                      ),
                    );


              }):Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'No new users to approved!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26 ),
                ),
              ),
            ],
          );

        }catch(e){
          return Text(
            'data : ' + e.toString(),
          );

        }

          }),
    );
  }
}
