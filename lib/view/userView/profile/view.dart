// // import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../model/services/session_controller.dart';
import '../../../res/colors.dart';
import '../../../res/components/adminViewComponents/custom_button.dart';
import '../../../utils/routes/routes_name.dart';
import 'index.dart';
// ... (imports remain the same)

class ProfileView extends GetView<profileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColour,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColour,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.profileImageBorder,
            fontSize: 20,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.getUserData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.circularProgressIndicatorColour,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.iconButtonBgColour,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: controller.image == null
                                      ? snapshot.data!['profile'].toString() == ""
                                      ? Icon(
                                    Icons.person_outline,
                                    size: 35,
                                    color:
                                    AppColors.iconButtonBgColour,
                                  )
                                      : Image(
                                    image: NetworkImage(
                                      snapshot.data!['profile']
                                          .toString(),
                                    ),
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, object, stack) {
                                      return Container(
                                        child: Icon(
                                          Icons.error_outline,
                                          color: AppColors.errorColor,
                                        ),
                                      );
                                    },
                                  )
                                      : Stack(
                                    children: [
                                      Image.file(
                                        File(controller.image!.path)
                                            .absolute,
                                      ),
                                      Center(
                                          child:
                                          CircularProgressIndicator())
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.pickImage(context);
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.tittleColour,
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showUserNameDialogAlert(
                                context,
                                snapshot.data!['UserName'].toString());
                          },
                          child: ReusableRow(
                            title: 'UserName',
                            iconData: Icons.drive_file_rename_outline,
                            value: snapshot.data!['UserName'].toString(),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.showUserEmailDialogAlert(
                                context, snapshot.data!['Email'].toString());
                          },
                          child: ReusableRow(
                            title: 'Email',
                            iconData: Icons.email_outlined,
                            value: snapshot.data!['Email'],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(height: 20.h,),
                        ReuseButton(
                          iconColor: AppColors.buttonBgColor, // Adjust color
                          borderColor: AppColors.buttonBgColor, // Adjust color
                          icon: Icons.login_outlined,
                          tittle: 'logout',
                          onpress: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut().then((value) {
                              SessionController().userid = '';
                              Get.toNamed(RouteNames.loginview);
                            }).onError((error, stackTrace) {
                              Get.snackbar('Error', error.toString());
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  ReusableRow({
    Key? key,
    required this.title,
    required this.iconData,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.iconButtonBgColour),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        title: TextField(
          decoration: InputDecoration(
            hintText: title,
            border: InputBorder.none,
          ),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        leading: Icon(
          iconData,
          color: AppColors.iCONColour,
        ),
        trailing: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.buttonBgColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              value,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
      ),
    );
  }
}





// class profileView extends GetView<profileController> {
//   const profileView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBgColour,
//       appBar: AppBar(
//         backgroundColor: AppColors.appBarBgColour,
//         title: const Text('Profile',style: TextStyle(
//           color: AppColors.profileImageBorder,fontSize: 20
//         ),),
//         // centerTitle: true,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
//                stream: controller.getUserData(),
//               // stream: ref.child(SessionController().userid.toString()).onValue,
//               builder: ( context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: CircularProgressIndicator(color: AppColors.circularProgressIndicatorColour,),
//                   );
//                 } else if (snapshot.hasData) {
//                   //here we get the daTA in the form of map such as it name email etc
//                   //dynamic sy jo bhi data ki type ho gae khud hi adjust kr le ga
//                   // Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 40,
//                         ),
//                         Stack(
//                           alignment: Alignment.bottomCenter,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: Container(
//                                 height: 130,
//                                 width: 130,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: AppColors.iconButtonBgColour,
//                                     width: 3, // Adjust border width as needed
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 2,
//                                       blurRadius: 7,
//                                       offset: Offset(0, 3),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: controller.image == null
//                                       ? snapshot.data!['profile'].toString() == ""
//                                       ? Icon(Icons.person_outline, size: 35, color: AppColors.iconButtonBgColour)
//                                       : Image(
//                                     image: NetworkImage(
//                                       snapshot.data!['profile'].toString(),
//                                     ),
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, object, stack) {
//                                       return Container(
//                                         child: Icon(
//                                           Icons.error_outline,
//                                           color: AppColors.errorColor,
//                                         ),
//                                       );
//                                     },
//                                   )
//                                       : Stack(
//                                     children: [
//                                       Image.file(
//                                         File(controller.image!.path).absolute,
//                                       ),
//                                       Center(child: CircularProgressIndicator())
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 controller.pickImage(context);
//                               },
//                               child: CircleAvatar(
//                                 radius: 14,
//                                 backgroundColor: AppColors.iconButtonBgColour,
//                                 child: Icon(
//                                   Icons.add,
//                                   size: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//
//
//
//                         // Stack(
//                         //   alignment: Alignment.bottomCenter,
//                         //   children: [
//                         //     Padding(
//                         //       padding: const EdgeInsets.symmetric(vertical: 10),
//                         //       child: Center(
//                         //         child: Container(
//                         //           height: 130,
//                         //           width: 130,
//                         //           decoration: BoxDecoration(
//                         //               shape: BoxShape.circle,
//                         //               border: Border.all(
//                         //                 color: AppColors.iconButtonBgColour,
//                         //               )),
//                         //           child: ClipRRect(
//                         //             borderRadius: BorderRadius.circular(100),
//                         //             child:controller.image==null ?
//                         //                 snapshot.data!['profile'].toString()==""
//                         //                 ? Icon(Icons.person_outline, size: 35)
//                         //                 : Image(
//                         //               image: NetworkImage(
//                         //                 snapshot.data!['profile'].toString(),
//                         //                 // map['profile'].toString(),
//                         //               ),
//                         //               fit: BoxFit.cover,
//                         //               // loadingBuilder:
//                         //               //     (context, child, loadingProgres) {
//                         //               //   if (loadingProgres == null) return child;
//                         //               //   return Center(
//                         //               //     child: CircularProgressIndicator(),
//                         //               //   );
//                         //               // },
//                         //               errorBuilder: (context, object, stack) {
//                         //                 return Container(
//                         //                   child: Icon(
//                         //                     Icons.error_outline,
//                         //                     color: AppColors.errorColor,
//                         //                   ),
//                         //                 );
//                         //               },
//                         //             ):
//                         //             Stack(
//                         //               children: [
//                         //                 Image.file(
//                         //                     File(controller.image!.path).absolute
//                         //                 ),
//                         //                 Center(
//                         //                     child: CircularProgressIndicator())
//                         //               ],
//                         //             ),
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ),
//                         //     InkWell(
//                         //       onTap: (){
//                         //         controller.pickImage(context);
//                         //       },
//                         //       child: CircleAvatar(
//                         //         radius: 14,
//                         //         backgroundColor: AppColors.iCONColour,
//                         //         child: Icon(
//                         //           Icons.add,size: 16,color: Colors.white,
//                         //         ),
//                         //       ),
//                         //     )
//                         //   ],
//                         // ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             controller.showUserNameDialogAlert(context,
//                                 snapshot.data!['UserName'].toString());
//                             // controller.showUserNameDialogAlert(context,map['username']);
//
//                           },
//                           child: ReusableRow(
//                               title: 'UserName',
//                               iconData: Icons.drive_file_rename_outline,
//                               value: snapshot.data!['UserName'].toString()),
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         GestureDetector(
//                           onTap: (){
//                             controller.showUserEmailDialogAlert(context,
//                                 snapshot.data!['Email'].toString()
//
//                                 // map['email']
//                                 );
//                           },
//                           child: ReusableRow(
//                               title: 'Email',
//                               iconData: Icons.email_outlined,
//                               value:snapshot.data!['Email']
//                               // map['email']
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                         SizedBox(height: 20.h,),
//                         ReuseButton(
//                           iconColor: Colors.blue,
//                           borderColor: Colors.blue,
//                           icon: Icons.login_outlined,
//                             tittle: 'logout', onpress:(){
//                           FirebaseAuth auth =FirebaseAuth.instance;
//                           auth.signOut().then((value){
//                             //here we logout user and clear its ud
//                             SessionController().userid='';
//                             Get.toNamed(RouteNames.loginview);
//                           }).onError((error, stackTrace){
//                             Get.snackbar('Error', error.toString());
//                           });
//
//                         }),
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return Center(
//                       child: Text(
//                         'Something went wrong',
//                         style: Theme.of(context).textTheme.subtitle1,
//                       ));
//                 }
//               },
//             ),
//           ),
//         ),
//       )
//     );
//   }
// }
// class ReusableRow extends StatelessWidget {
//   final String title, value;
//   final IconData iconData;
//
//   ReusableRow({
//     Key? key,
//     required this.title,
//     required this.iconData,
//     required this.value,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.iconButtonBgColour), // Adjust the color as needed
//         borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
//       ),
//       child: ListTile(
//         title: TextField(
//           decoration: InputDecoration(
//             hintText: title,
//             border: InputBorder.none,
//           ),
//           style: Theme.of(context).textTheme.subtitle2,
//         ),
//         leading: Icon(
//           iconData,
//           color: Colors.blue, // Adjust the color as needed
//         ),
//         trailing: Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.blue), // Adjust the color as needed
//             borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               value,
//               style: Theme.of(context).textTheme.subtitle2,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

