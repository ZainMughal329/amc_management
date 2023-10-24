import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../res/colors.dart';
import '../index.dart';
class userApproval extends GetView<userController> {
  const userApproval({super.key});
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: controller.firestore,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        try{
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasData){
            if(snapshot.data!.docs.length !=0){
              return snapshot.data!.docs.length !=0?
              ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        height: 130.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.warningColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.lightTextFormFieldColor.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListTile(
                              leading: Container(
                                height: 40.w,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: AppColors.unActiveIconColor,
                                  border: Border.all(
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: snapshot.data!.docs[index]['profile'].toString() == ''
                                      ? Icon(
                                    Icons.person_outline,
                                    size: 30,
                                    color: AppColors.lightActiveIconColor,
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
                            SizedBox(
                              height: 20,
                            ),
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
                                  child: Text('Decline' , style: TextStyle(color: Colors.red),),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    controller.updateUserData(
                                        snapshot.data!.docs[index].id
                                            .toString());
                                  },
                                  child: Text('Approve' , style: TextStyle(color: AppColors.SuccessColor),),
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
            }

          }
          return CircularProgressIndicator(color: Colors.orange,);

        }catch(e){
          return Text(
            'data : ' + e.toString(),
          );
        }

          }),
    );
  }
}
