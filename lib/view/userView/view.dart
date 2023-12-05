import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/SessionViewComponents/elevated_button.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_button.dart';
import 'package:amc_management/view/userView/detailsScreen/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import '../../../model/services/session_Controller.dart';
import '../../../model/userModel/user_model.dart';
import '../../../res/components/UserViewComponents/userApprovalPage.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/snackBar.dart';
import 'index.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class userView extends GetView<userViewController> {
  String deptName;
  userView({super.key, required this.deptName});
  final controller = Get.put<userViewController>(userViewController());
  @override
  Widget build(BuildContext context) {
    controller.state.dpName = deptName;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColour,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColour,
        title: Text(
          'GAMC DOC',
          style: TextStyle(color: AppColors.tittleColour, fontSize: 24),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.iconButtonBgColour,
            child: IconButton(
                onPressed: () {
                  Get.toNamed(RouteNames.profileview);
                },
                icon: Icon(
                  Icons.person_outline,
                  color: AppColors.iCONColour,
                )),
          ),
          SizedBox(width: 10.w),
          CircleAvatar(
            backgroundColor: AppColors.iconButtonBgColour,
            child: IconButton(
                onPressed: () {
                  controller.state.auth.signOut().then((value) {
                    SessionController().userid = '';
                    Get.offAllNamed(RouteNames.loginview);
                  }).then((value) {
                    Snackbar.showSnackBar('Error', 'Something went wrong');
                  });
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: AppColors.iCONColour,
                )),
          ),
          SizedBox(width: 15.w),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: controller.getUsersData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data as UserModel;
                if (user.status == "true") {
                  return StreamBuilder<QuerySnapshot>(
                      stream: controller.state.firestoreRef
                          .where('Dept',
                          arrayContains: controller.state.dpName
                          // isEqualTo: controller.state.dpName
                      )
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          print('inside if');
                          print('length is' +
                              snapshot.data!.docs.length.toString());
                          return snapshot.data!.docs.length != 0
                              ? ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    // final idFromDb = int.parse(snapshot
                                    //     .data!.docs[index]['Id']
                                    //     .toString());
                                    // final timeInMilli =
                                    //     DateTime.fromMillisecondsSinceEpoch(
                                    //         idFromDb);
                                    // final formattedDate = DateFormat('dd-MM-yy')
                                    //     .format(timeInMilli);
                                    // print('date is : ' +
                                    //     formattedDate.toString());
                                    // print('length is1' +
                                    //     snapshot.data!.docs.length.toString());
                                    // final tittle = snapshot
                                    //     .data!.docs[index]['Name']
                                    //     .toString();

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: AppColors.cardBgColour,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        elevation: 5,
                                        shadowColor:  Color(0xFFE3CBB3),
                                        margin: EdgeInsets.all(10.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildListTile(
                                                icon: Icons.file_copy_rounded,
                                                title: 'Serial Number',
                                                content: snapshot
                                                    .data!.docs[index]['serialNum']
                                                    .toString(),
                                              ),
                                              _buildListTile(
                                                icon: Icons.person_outline,
                                                title: 'sender Name',
                                                content: snapshot
                                                    .data!.docs[index]['senderName']
                                                    .toString(),
                                              ),
                                              // _buildListTile(
                                              //   icon: Icons.date_range,
                                              //   title: 'Date',
                                              //   content: formattedDate,
                                              // ),
                                              Center(
                                                child: ReuseButton(
                                                  icon:
                                                      Icons.image_search_outlined,
                                                  tittle: 'images',
                                                  onpress: () {
                                                    final id = snapshot
                                                        .data!.docs[index]['Id'];
                                                    Get.to(UserViewImages(
                                                      id: id,
                                                    ));
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                    ;
                                    ;
                                  })
                              : Center(
                                  child: Icon(
                                    Icons.file_copy_outlined,
                                    size: 50,
                                  ),
                                );
                        } else if (snapshot.hasError) {
                          return CircularProgressIndicator();
                        } else {
                          return Container();
                        }
                      });
                } else {
                  return userApprovalPage();
                }
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: CircularProgressIndicator())],
                );
              }
            }),
      ),
    );
  }
}

Widget _buildListTile({
  required IconData icon,
  required String title,
  required String content,
}) {
  return Column(
    children: [
      ListTile(
        dense: true, // Reduces the height of the ListTile
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        leading: Icon(icon, color: AppColors.iCONColour, size: 22),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: AppColors.tittleColour),
        ),
        trailing: Text(
          content,
          style: TextStyle(fontSize: 14, color: AppColors.cardTextColourS),
        ),
      ),
      SizedBox(height: 4),
    ],
  );
}

