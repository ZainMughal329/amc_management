import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../model/userModel/user_model.dart';
import '../../../res/components/userApprovalPage.dart';
import '../../model/services/session_Controller.dart';
import '../../utils/routes/routes_name.dart';
import 'index.dart';
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
      appBar: AppBar(
        title: Text('GAMC DOC',
        style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 25,color: Colors.lightBlue
        ),
        ),
        actions: [
          IconButton(onPressed: (){
            Get.toNamed(RouteNames.profileview);
          }, icon: Icon(Icons.person_outline)),
          IconButton(onPressed: (){
    controller.state.auth.signOut().then((value){
      SessionController().userid='';
      Get.to(RouteNames.loginview);
    }).onError((error, stackTrace){
      Get.snackbar('Error', error.toString());
    });
          }, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body:  SafeArea(
                child: FutureBuilder(
                    future: controller.getUsersData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserModel user = snapshot.data as UserModel;
                        if (user.status == "true") {
                          return StreamBuilder<QuerySnapshot>(
                              stream: controller.state.firestoreRef
                                  .where('Dept',
                                      isEqualTo: controller.state.dpName)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  print('inside if');
                                  print('length is' +
                                      snapshot.data!.docs.length.toString());
                                  return snapshot.data!.docs.length != 0
                                      ?
                                  ListView.builder(
                                          itemCount:
                                              snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            print('length is1' +
                                                snapshot.data!.docs.length
                                                    .toString());
                                            final tittle = snapshot.data!.docs[index]['Name']
                                                .toString();

                                            return Container(
                                              height: 230.h,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                      top: 35,
                                                      left: 20,
                                                      child: Material(
                                                        child: Container(
                                                          height: 180.0.h,
                                                          // width: ,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(0.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey.withOpacity(0.3),
                                                                  offset: Offset(-10.0, 10.0),
                                                                  blurRadius: 20.0,
                                                                  spreadRadius: 4.0 // Extent of the shadow
                                                              ),
                                                            ],

                                                          ),
                                                        ),
                                                      )),
                                                  Positioned(
                                                      top: 0,
                                                      left: 30,
                                                      child:Card(
                                                        elevation: 10.0,
                                                        shadowColor: Colors.grey.withOpacity(0.5),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(15.0)
                                                        ),
                                                        child: Container(
                                                          height: 200.h,
                                                          width: 150.w,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                              image: DecorationImage(
                                                                fit: BoxFit.fill,
                                                                image: AssetImage(snapshot.data!.docs[index]['Image']),)
                                                          ),
                                                        ),
                                                      ) ),
                                                  Positioned(
                                                      top: 60,
                                                      left: 220,
                                                      child: Container(
                                                        height: 150.h,
                                                        width: 160.w,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(snapshot.data!.docs[index]['Name']
                                                                .toString(),style: TextStyle(
                                                                fontSize: 20,
                                                                color: Color(0xFF363f93),
                                                                fontWeight: FontWeight.bold
                                                            ),),
                                                            Text(
                                                              snapshot.data!.docs[index]['FileNum'].toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.grey,
                                                                  fontWeight: FontWeight.bold
                                                              ),),
                                                            Divider(color: Colors.black,),
                                                            Text(
                                                              snapshot.data!.docs[index]['Date'].toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors.grey,
                                                                  fontWeight: FontWeight.bold
                                                              ),),

                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            );


                                            // if(controller.state.searchController.text.isEmpty){
                                            //   return Container(
                                            //     height: 230.h,
                                            //     child: Stack(
                                            //       children: [
                                            //         Positioned(
                                            //             top: 35,
                                            //             left: 20,
                                            //             child: Material(
                                            //               child: Container(
                                            //                 height: 180.0.h,
                                            //                 // width: ,
                                            //                 decoration: BoxDecoration(
                                            //                   color: Colors.white,
                                            //                   borderRadius: BorderRadius.circular(0.0),
                                            //                   boxShadow: [
                                            //                     BoxShadow(
                                            //                         color: Colors.grey.withOpacity(0.3),
                                            //                         offset: Offset(-10.0, 10.0),
                                            //                         blurRadius: 20.0,
                                            //                         spreadRadius: 4.0 // Extent of the shadow
                                            //                     ),
                                            //                   ],
                                            //
                                            //                 ),
                                            //               ),
                                            //             )),
                                            //         Positioned(
                                            //             top: 0,
                                            //             left: 30,
                                            //             child:Card(
                                            //               elevation: 10.0,
                                            //               shadowColor: Colors.grey.withOpacity(0.5),
                                            //               shape: RoundedRectangleBorder(
                                            //                   borderRadius: BorderRadius.circular(15.0)
                                            //               ),
                                            //               child: Container(
                                            //                 height: 200.h,
                                            //                 width: 150.w,
                                            //                 decoration: BoxDecoration(
                                            //                     borderRadius: BorderRadius.circular(10.0),
                                            //                     image: DecorationImage(
                                            //                       fit: BoxFit.fill,
                                            //                       image: AssetImage(snapshot.data!.docs[index]['Image']),)
                                            //                 ),
                                            //               ),
                                            //             ) ),
                                            //         Positioned(
                                            //             top: 60,
                                            //             left: 220,
                                            //             child: Container(
                                            //               height: 150.h,
                                            //               width: 160.w,
                                            //               child: Column(
                                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                                            //                 children: [
                                            //                   Text(snapshot.data!.docs[index]['Name']
                                            //                       .toString(),style: TextStyle(
                                            //                       fontSize: 20,
                                            //                       color: Color(0xFF363f93),
                                            //                       fontWeight: FontWeight.bold
                                            //                   ),),
                                            //                   Text(
                                            //                     snapshot.data!.docs[index]['FileNum'].toString(),
                                            //                     style: TextStyle(
                                            //                         fontSize: 16,
                                            //                         color: Colors.grey,
                                            //                         fontWeight: FontWeight.bold
                                            //                     ),),
                                            //                   Divider(color: Colors.black,),
                                            //                   Text(
                                            //                     snapshot.data!.docs[index]['Date'].toString(),
                                            //                     style: TextStyle(
                                            //                         fontSize: 16,
                                            //                         color: Colors.grey,
                                            //                         fontWeight: FontWeight.bold
                                            //                     ),),
                                            //
                                            //                 ],
                                            //               ),
                                            //             ))
                                            //       ],
                                            //     ),
                                            //   );
                                            // }
                                            // else if(tittle.toLowerCase().contains(controller.state.searchController.text.toLowerCase().toLowerCase())){
                                            //   return Container(
                                            //     height: 230.h,
                                            //     child: Stack(
                                            //       children: [
                                            //         Positioned(
                                            //             top: 35,
                                            //             left: 20,
                                            //             child: Material(
                                            //               child: Container(
                                            //                 height: 180.0.h,
                                            //                 // width: ,
                                            //                 decoration: BoxDecoration(
                                            //                   color: Colors.white,
                                            //                   borderRadius: BorderRadius.circular(0.0),
                                            //                   boxShadow: [
                                            //                     BoxShadow(
                                            //                         color: Colors.grey.withOpacity(0.3),
                                            //                         offset: Offset(-10.0, 10.0),
                                            //                         blurRadius: 20.0,
                                            //                         spreadRadius: 4.0 // Extent of the shadow
                                            //                     ),
                                            //                   ],
                                            //
                                            //                 ),
                                            //               ),
                                            //             )),
                                            //         Positioned(
                                            //             top: 0,
                                            //             left: 30,
                                            //             child:Card(
                                            //               elevation: 10.0,
                                            //               shadowColor: Colors.grey.withOpacity(0.5),
                                            //               shape: RoundedRectangleBorder(
                                            //                   borderRadius: BorderRadius.circular(15.0)
                                            //               ),
                                            //               child: Container(
                                            //                 height: 200.h,
                                            //                 width: 150.w,
                                            //                 decoration: BoxDecoration(
                                            //                     borderRadius: BorderRadius.circular(10.0),
                                            //                     image: DecorationImage(
                                            //                       fit: BoxFit.fill,
                                            //                       image: AssetImage(""),)
                                            //                 ),
                                            //               ),
                                            //             ) ),
                                            //         Positioned(
                                            //             top: 60,
                                            //             left: 220,
                                            //             child: Container(
                                            //               height: 150.h,
                                            //               width: 160.w,
                                            //               child: Column(
                                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                                            //                 children: [
                                            //                   Text(snapshot.data!.docs[index]['Name']
                                            //                       .toString(),style: TextStyle(
                                            //                       fontSize: 20,
                                            //                       color: Color(0xFF363f93),
                                            //                       fontWeight: FontWeight.bold
                                            //                   ),),
                                            //                   Text(
                                            //                     snapshot.data!.docs[index]['FileNum'].toString(),
                                            //                     style: TextStyle(
                                            //                         fontSize: 16,
                                            //                         color: Colors.grey,
                                            //                         fontWeight: FontWeight.bold
                                            //                     ),),
                                            //                   Divider(color: Colors.black,),
                                            //                   Text(
                                            //                     snapshot.data!.docs[index]['Date'].toString(),
                                            //                     style: TextStyle(
                                            //                         fontSize: 16,
                                            //                         color: Colors.grey,
                                            //                         fontWeight: FontWeight.bold
                                            //                     ),),
                                            //
                                            //                 ],
                                            //               ),
                                            //             ))
                                            //       ],
                                            //     ),
                                            //   );
                                            //
                                            // }
                                            // else{
                                            //   return Container()  ;
                                            // }

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
                          children: [CircularProgressIndicator()],
                        );
                      }
                    }),
              ),
    //   Card(
      //                                               child: ListTile(
      //                                                 title: Text(
      //                                                   snapshot.data!.docs[index]['Name']
      //                                                       .toString(),
      //                                                   style: TextStyle(
      //                                                       color: Colors.red,
      //                                                       fontSize: 15),
      //                                                 ),
      //                                                 subtitle: Text(
      //                                                   snapshot.data!.docs[index]['Date']
      //                                                       .toString(),
      //                                                   style: TextStyle(
      //                                                       color: Colors.purpleAccent,
      //                                                       fontSize: 15),
      //                                                 ),
      //                                                 trailing: Text(
      //                                                   snapshot
      //                                                       .data!.docs[index]['FileNum']
      //                                                       .toString(),
      //                                                   style: TextStyle(
      //                                                       color: Colors.greenAccent,
      //                                                       fontSize: 15),
      //                                                 ),
      //                                               ),
      //                                             )
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
//
//
//
//
//                     Column(
//                             children: [
//
//                               Center(child: Text('Wahab'+ controller.state.dpName.toString())),
//                               SizedBox(height: 100.h,),
//                             TextButton(
//                           onPressed: ()async{
//                             await FirebaseAuth.instance.signOut().then((value){
//                               SessionController().userid = '';
//                               Get.offAllNamed(RouteNames.loginview);
//                             }).onError((error, stackTrace){
//
//                             });
//                           },
//                               child: Text("Logout"),
//                           )
//                             ],
//                           ))
