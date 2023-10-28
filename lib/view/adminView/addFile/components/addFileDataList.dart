import 'package:amc_management/res/components/custom_card_widget.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../fileshow.dart';
import '../index.dart';
class addFileDataList extends GetView<addFileController> {
  const addFileDataList({super.key});
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: controller.state.ref.snapshots(),
          builder:(BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              return snapshot.data!.docs.length !=0?
              ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder:(context,index){
                    return InkWell(
                      onTap: (){
                        Get.to(
                            ()=>addFileShowContainer(date: snapshot.data!.docs[index]['Date'],
                                name: snapshot.data!.docs[index]['Name'],

                                fileNum: snapshot.data!.docs[index]['FileNum'],
                                from: snapshot.data!.docs[index]['From'])

                        );
                      },
                    child: CustomCardWidget(
                    imagePath: snapshot.data!.docs[index]['image'],
                    date: snapshot.data!.docs[index]['Date'],
                    receiverName: snapshot.data!.docs[index]['From'],
                    fileNumber: snapshot.data!.docs[index]['FileNum'],
                    fileName: snapshot.data!.docs[index]['Name'],
                    deptName: snapshot.data!.docs[index]['Dept'],
                    ));
                      // child:Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 5),
                      //   child: Container(
                      //     height: 200.h,
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
                      //                   borderRadius:
                      //                   BorderRadius.circular(
                      //                       0.0),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                         color: Colors.grey
                      //                             .withOpacity(0.3),
                      //                         offset: Offset(
                      //                             -10.0, 10.0),
                      //                         blurRadius: 20.0,
                      //                         spreadRadius:
                      //                         4.0 // Extent of the shadow
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             )),
                      //         Positioned(
                      //             top: 0,
                      //             left: 30,
                      //             child: Card(
                      //               elevation: 10.0,
                      //               shadowColor: Colors.grey
                      //                   .withOpacity(0.5),
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius:
                      //                   BorderRadius.circular(
                      //                       15.0)),
                      //               child: Container(
                      //                 height: 100.h,
                      //                 width: 80.w,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius:
                      //                     BorderRadius.circular(
                      //                         10.0),
                      //                     image: DecorationImage(
                      //                       fit: BoxFit.fill,
                      //                       image: NetworkImage(
                      //                           snapshot.data!
                      //                               .docs[index]
                      //                           ['image']),
                      //                     )),
                      //               ),
                      //             )),
                      //         Positioned(
                      //             top: 60,
                      //             left: 220,
                      //             child: Container(
                      //               height: 150.h,
                      //               width: 160.w,
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                 CrossAxisAlignment.start,
                      //                 children: [
                      //                   Row(
                      //                     children: [
                      //                      Icon(Icons.drive_file_rename_outline_outlined),
                      //                       Text(
                      //                         snapshot.data!
                      //                             .docs[index]['Name']
                      //                             .toString(),
                      //                         style: TextStyle(
                      //                             fontSize: 20,
                      //                             color:
                      //                             Color(0xFF363f93),
                      //                             fontWeight:
                      //                             FontWeight.bold),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Icon(Icons.numbers_outlined),
                      //                       Text(
                      //                         snapshot
                      //                             .data!
                      //                             .docs[index]
                      //                         ['FileNum']
                      //                             .toString(),
                      //                         style: TextStyle(
                      //                             fontSize: 16,
                      //                             color: Colors.grey,
                      //                             fontWeight:
                      //                             FontWeight.bold),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   Divider(
                      //                     color: Colors.black,
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Icon(Icons.date_range_outlined),
                      //                       Text(
                      //                         snapshot.data!
                      //                             .docs[index]['Date']
                      //                             .toString(),
                      //                         style: TextStyle(
                      //                             fontSize: 16,
                      //                             color: Colors.grey,
                      //                             fontWeight:
                      //                             FontWeight.bold),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Icon(Icons.person_outline),
                      //                       Text(
                      //                         snapshot.data!
                      //                             .docs[index]['From']
                      //                             .toString(),
                      //                         style: TextStyle(
                      //                             fontSize: 20,
                      //                             color:
                      //                             Color(0xFF363f93),
                      //                             fontWeight:
                      //                             FontWeight.bold),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Icon(Icons.house_outlined),
                      //                       Text(
                      //                         snapshot.data!
                      //                             .docs[index]['Dept']
                      //                             .toString(),
                      //                         style: TextStyle(
                      //                             fontSize: 20,
                      //                             color:
                      //                             Color(0xFF363f93),
                      //                             fontWeight:
                      //                             FontWeight.bold),
                      //                       ),
                      //                     ],
                      //                   )
                      //                 ],
                      //               ),
                      //             ))
                      //       ],
                      //     ),
                      //   ),
                      // ) );
                  }):Container();
            }
            else if (snapshot.hasError){
              return CircularProgressIndicator();
            }
            else {
              return Container();
            }
          }),
    );
  }
}
//

// Card(
//                         child: Padding(padding: EdgeInsets.all(8.0),
//                           child: ListTile(
//                             title:Text(snapshot.data!.docs[index]['Name'].toString()),
//                             subtitle: Text(
//                               snapshot.data!.docs[index]['Date'].toString(),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             // leading: CircleAvatar(
//                             //   child:Image(image: NetworkImage(controller.imagePath.toString())),
//                             // ),
//                             trailing: Text(snapshot.data!.docs[index]['From'].toString(),
//                     style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     )
//                     ),
//                           ),
//                       ),
//                     )

