import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/custom_button.dart';
import '../../../../utils/routes/routes_name.dart';
import '../dispatchfileshow.dart';
import '../index.dart';

class FileList extends GetView<dispatchController> {
  const FileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 110,top: 0),
          child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: controller.state.ref.snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
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
                        print('date is : ' + formattedDate.toString());
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
                                  _buildListTile(icon: Icons.numbers_outlined, title: 'Serial Number', content:  snapshot.data!.docs[index]
                                  ['serialNum']),
                                  _buildListTile(icon: Icons.date_range_outlined, title: 'Date', content:formattedDate),
                                  _buildListTile(icon: Icons.person_outlined, title: 'Received Name', content: snapshot.data!.docs[index]
                                  ['recieverName']),
                                  _buildListTile(icon:Icons.cabin , title: 'Letter Num', content:snapshot.data!.docs[index]
                                  ['letterNum'], ),




                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        ReuseButton(
                                            icon: Icons.details_outlined,
                                            tittle: 'Details', onpress:(){
                                          Get.to(() =>
                                              dispatchFileShowContainer(
                                                  date: formattedDate,
                                                  recieverName: snapshot.data!.docs[index]['receiverName'],
                                                  receiverAddress: snapshot.data!.docs[index]['receiverAddress'],
                                                  id: snapshot.data!.docs[index]
                                                  ['Id'],
                                                  letterNum: snapshot.data!.docs[index]['letterNum'],
                                                  // Dept: snapshot
                                                  //     .data!
                                                  //     .docs[index]
                                                  // ['dept'],
                                                  subject: snapshot.data!.docs[index]['subject'],
                                                  serialNum: snapshot
                                                      .data!
                                                      .docs[index]
                                                  ['serialNum'],


                                              ));
                                        } ),
                                        ReuseButton(
                                            icon: Icons.delete_forever,
                                            tittle: 'Delete', onpress: (){
                                          final id = snapshot.data!.docs[index]['Id'];
                                          controller.deleteFile(id);
                                        })
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      })
                      : Container();
                } else if (snapshot.hasError) {
                  return CircularProgressIndicator();
                } else {
                  return Container();
                }
              }),
      ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40,bottom: 40,left: 40,right: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: (){
                Get.toNamed(RouteNames.disptchsearchView);
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.filesCardBgColour.withOpacity(0.8),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                    // topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Search files',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ),

      ]
    );
  }
}

// Get.to(()=>dispatchFileShowContainer(
//                             recievedBy: snapshot.data!.docs[index]['RecievedBy'],
//                             details: snapshot.data!.docs[index]['Detail'],
//                             date: formattedDate,
//                             name: snapshot.data!.docs[index]['Name'],
//                             img: snapshot.data!.docs[index]['Image'],
//                             notificationTo: snapshot.data!.docs[index]['NotificationTo'],
//                             ));
// child: Container(
// height: 200.h,
// child: Card(
// child: Padding(
// padding: EdgeInsets.all(8.0),
// child:
// Column(
// mainAxisAlignment:
// MainAxisAlignment.start,
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// SizedBox(
// height: 10,
// ),
// Row(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceEvenly,
// children: [
// Text("FileName\n" +
// snapshot
//     .data!
//     .docs[index]
// ['Name']
//     .toString()),
// SizedBox(
// height: 10,
// ),
// Text("Date\n" +
// formattedDate,
// overflow: TextOverflow.ellipsis,
// )
// ],
// ),
// SizedBox(
// height: 20,
// ),
// Row(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceEvenly,
// children: [
// Text("RecievedBy\n" +
// snapshot
//     .data!
//     .docs[index]
// ['RecievedBy']
//     .toString()),
// SizedBox(
// height: 10,
// ),
// Text("NotificationTo\n" +
// snapshot
//     .data!
//     .docs[index][
// 'NotificationTo']
//     .toString())
// ],
// )
// ],
// ),
// ),
// ),
// ),
// //
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
        leading: Icon(icon, color: AppColors.filesCardBgColour.withOpacity(0.8), size: 22),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: AppColors.filesCardBgColour.withOpacity(0.8)),
        ),
        trailing: Text(
          content,
          style: TextStyle(fontSize: 14, color: AppColors.filesCardBgColour.withOpacity(0.8)),
        ),
      ),
      SizedBox(height: 4),
    ],
  );
}


