import 'package:amc_management/res/colors.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_button.dart';
import 'package:amc_management/res/components/textWidget.dart';
import 'package:amc_management/view/userView/detailsScreen/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../model/services/session_Controller.dart';
import '../../../model/userModel/user_model.dart';
import '../../../res/components/UserViewComponents/userApprovalPage.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/snackBar.dart';
import 'index.dart';
import 'searchFile/contoller.dart';
import 'searchFile/view.dart';
import 'package:flutter/services.dart';
class userView extends GetView<userViewController> {
  String deptName;
  userView({super.key, required this.deptName});
  final controller = Get.put<userViewController>(userViewController());
  final con = Get.put(userSerachController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    controller.state.dpName = deptName;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppColors.filesBgColour,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColour,
        title: TextWidget(
          style: TextStyle(color: AppColors.tittleColour, fontSize: 24), title: 'GAMC DOC',
        ),
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.iconButtonBgColour,
            child: IconButton(
                onPressed: () {
                  Get.to(()=>userSearchView());
                },
                icon: Icon(
                  Icons.search_outlined,
                  color: AppColors.iCONColour,
                )),
          ),
          SizedBox(width: 10.w),
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
                    Get.snackbar('Error','Something went wrong',backgroundColor:Colors.white ,colorText: Colors.blueGrey.withOpacity(.8));

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
                                    final idFromDb = int.parse(
                                        snapshot.data!.docs[index]['Id'].toString());
                                    final timeInMilli =
                                    DateTime.fromMillisecondsSinceEpoch(idFromDb);
                                    final formattedDate =
                                    DateFormat('dd-MM-yy').format(timeInMilli);
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: AppColors.filesCardBgColour.withOpacity(0.8),
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
                                                icon: Icons.date_range_outlined,
                                                title: 'Date',
                                                content: formattedDate
                                              ),
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
                          return CircularProgressIndicator(color: Colors.blueGrey.withOpacity(.8),);
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
                  children: [Center(child: CircularProgressIndicator(color: Colors.blueGrey.withOpacity(.8),))],
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
        leading: Icon(icon, color: AppColors.filesCardTextColour, size: 22),
        title: Text(
          title,
          style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16, color: AppColors.filesCardTextColour)),
        ),
        trailing: Text(
          content,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 14, color: AppColors.filesCardTextColour)
          ),
        ),
      ),
      SizedBox(height: 4),
    ],
  );
}