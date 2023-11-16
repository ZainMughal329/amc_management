import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
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
                        return Card(
                          // elevation: 4,
                          color: AppColors
                              .elevatedButtonColour, // Add shadow to the card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Round the corners
                          ),
                          margin:
                          EdgeInsets.all(10.0), // Margin around the card

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                            ['Name'],
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white),
                                          ),
                                          Spacer(),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['Dept'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                            ['RecievedBy'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                          Spacer(),
                                          Text(
                                            snapshot.data!.docs[index]
                                            ['NotificationTo'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            formattedDate,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                          Spacer(),
                                          IconButton(onPressed: (){
                                            final id = snapshot.data!.docs[index]['Id'];
                                            controller.deleteFile(id);
                                          }, icon: Icon(Icons.delete_forever,color: Colors.white,)),
                                          Spacer(),
                                          Container(
                                            color: Color(0xffBEC3C7),
                                            width: 80,
                                            height: 40,
                                            child: TextButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      dispatchFileShowContainer(
                                                        date: formattedDate,
                                                        filenum: snapshot.data!.docs[index]['FileNum'],
                                                        Dept: snapshot.data!.docs[index]['Dept'],
                                                        id: snapshot.data!.docs[index]['Id'],
                                                        recievedBy: snapshot
                                                            .data!
                                                            .docs[index]
                                                        ['RecievedBy'],
                                                        details: snapshot
                                                            .data!
                                                            .docs[index]
                                                        ['Detail'],
                                                        // date: formattedDate,
                                                        name: snapshot.data!
                                                            .docs[index]
                                                        ['Name'],
                                                        notificationTo: snapshot
                                                            .data!
                                                            .docs[index][
                                                        'NotificationTo'],
                                                      ));
                                                },
                                                child: Text(
                                                  'Details',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .elevatedButtonColour),
                                                )),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                  color: AppColors.elevatedButtonColour,
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
