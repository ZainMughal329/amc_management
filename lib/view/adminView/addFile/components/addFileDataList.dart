import 'package:amc_management/res/components/SessionViewComponents/elevated_button.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_card_widget.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../res/colors.dart';
import 'addfileshow.dart';
import '../index.dart';

class addFileDataList extends GetView<addFileController> {
  const addFileDataList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 110,top: 10),
          child: Center(
            child: StreamBuilder<QuerySnapshot>(
                stream: controller.state.ref.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                color: AppColors.elevatedButtonColour,
                                // Add shadow to the card
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      16.0), // Round the corners
                                ),
                                margin: EdgeInsets.all(16.0),
                                // Margin around the card

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      ['dept'],
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
                                                      ['From'],
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                ),
                                                Spacer(),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ['FileNum'],
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
                                                Container(
                                                  color: Color(0xffBEC3C7),
                                                  width: 80,
                                                  height: 40,
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Get.to(() =>
                                                            addFileShowContainer(
                                                                // img: snapshot.data!.docs[index]['images'],
                                                                 date: formattedDate,
                                                                name: snapshot.data!.docs[index]
                                                                    ['Name'],
                                                                id: snapshot.data!.docs[index]
                                                                    ['Id'],
                                                                dept: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['dept'],
                                                                details: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['Detail'],
                                                                fileNum: snapshot
                                                                        .data!
                                                                        .docs[index]
                                                                    ['FileNum'],
                                                                from: snapshot
                                                                    .data!
                                                                    .docs[index]['From']));
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
                Get.toNamed(RouteNames.searchView);
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
      ],
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

//InkWell(

//                     child: CustomCardWidget(
//                     // imagePath: snapshot.data!.docs[index]['images'],
//                      date: snapshot.data!.docs[index]['Date'],
//                     receiverName: snapshot.data!.docs[index]['From'],
//                     fileNumber: snapshot.data!.docs[index]['FileNum'],
//                     fileName: snapshot.data!.docs[index]['Name'],
//                     deptName: snapshot.data!.docs[index]['Dept'],
//                     ))
