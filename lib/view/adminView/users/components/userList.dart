import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../res/colors.dart';
import '../../sendFile/controller.dart';
import '../index.dart';

class userList extends GetView<userController> {
  userList({Key? key}) : super(key: key);
  final controller = Get.put(userController());

  @override
  Widget build(BuildContext context) {
    final sendController = Get.put(sendFileController());

    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: controller.state.ref.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            print('if');
            return snapshot.data!.docs.length != 0
                ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text(
                          snapshot.data!.docs[index]['UserName'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Text(
                        //   snapshot.data!.docs[index]['dept'].toString(),
                        //   style: TextStyle(
                        //     fontSize: 8,
                        //   ),
                        // ),
                      ]
                    ),
                    subtitle: Text(
                      snapshot.data!.docs[index]['Email'].toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        print('button pressed');
                        controller.deleteUsers(snapshot.data!.docs[index]['id'].toString());
                      },
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.iCONColour,
                      ),
                    ),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.lightActiveIconColor),
                      ),
                      child: snapshot.data!.docs[index]['profile'].toString() == ""
                          ? Icon(Icons.person_2_outlined, color: AppColors.iCONColour)
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(snapshot.data!.docs[index]['profile'].toString()),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
                : Container();
          } else if (snapshot.hasError) {
            print('else if');
            return Center(child: CircularProgressIndicator());
          } else {
            print('else');
            return Container();
          }
        },
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../res/colors.dart';
// import '../../sendFile/controller.dart';
// import '../index.dart';
//
// class userList extends GetView<userController> {
//   userList({Key? key}) : super(key: key);
//   final controller = Get.put(userController());
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: controller.state.ref.collection('users').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             print('if');
//             return snapshot.data!.docs.length != 0
//                 ? ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 3,
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: ListTile(
//                     title: Text(
//                       snapshot.data!.docs[index]['UserName'].toString(),
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     subtitle: Text(
//                       snapshot.data!.docs[index]['Email'].toString(),
//                       style: TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//                     trailing: IconButton(
//                       onPressed: () {
//                         print('button pressed');
//                         controller.deleteUsers(snapshot.data!.docs[index]['id'].toString());
//                       },
//                       icon: Icon(
//                         Icons.delete,
//                         color: AppColors.iCONColour,
//                       ),
//                     ),
//                     leading: Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: AppColors.lightActiveIconColor),
//                       ),
//                       child: snapshot.data!.docs[index]['profile'].toString() == ""
//                           ? Icon(Icons.person_2_outlined, color: AppColors.iCONColour)
//                           : ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: Image(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(snapshot.data!.docs[index]['profile'].toString()),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             )
//                 : Container();
//           } else if (snapshot.hasError) {
//             print('else if');
//             return Center(child: CircularProgressIndicator());
//           } else {
//             print('else');
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }
//
























// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../res/colors.dart';
// import '../../sendFile/controller.dart';
// import '../index.dart';
// class userList extends GetView<userController> {
//    userList({super.key});
//   final controller = Get.put(userController());
//   @override
//   Widget build(BuildContext context) {
//     final sendController = Get.put(sendFileController());
//     return Center(
//       child: StreamBuilder<QuerySnapshot>(
//           stream: controller.state.ref.collection('users').snapshots(),
//           builder: ( BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
//             if(snapshot.hasData){
//               print('if');
//               return snapshot.data!.docs.length !=0?
//               ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder:(context,index){
//                     return ListTile(
//                       title: Text(snapshot.data!.docs[index]['UserName'].toString(),
//                       ),
//                       subtitle: Text(snapshot.data!.docs[index]['Email'].toString(),style: TextStyle(
//                         fontSize: 12
//                       ),),
//
//                       trailing: IconButton(
//                         onPressed: (){
//                           print('button pressed');
//                           controller.deleteUsers(snapshot.data!.docs[index]['id'].toString());
//                         },
//                         icon: Icon(Icons.delete),
//                       ),
//                       leading: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: AppColors.lightActiveIconColor)
//                         ),
//                         child: snapshot.data!.docs[index]['profile'].toString()==""?
//                         Icon(Icons.person_2_outlined):ClipRRect(
//                           borderRadius: BorderRadius.circular(50),
//                           child: Image(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                                 snapshot.data!.docs[index]['profile'].toString()
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   } ):Container();
//             }
//             else if (snapshot.hasError){
//               print('else if');
//               return Center(child: CircularProgressIndicator());
//             }
//             else{
//               print('else');
//               return Container(); }
//           }
//       ),
//     );
//   }
// }




