


import 'package:amc_management/view/home/dispatchFile/controller.dart';
import 'package:amc_management/view/home/dispatchFile/fileshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileList extends GetView<dispatchController> {
  const FileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: controller.state.ref.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.docs.length != 0
                  ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(

                      onTap: (){
                        Get.to(()=>dispatchFileShowContainer(date: snapshot.data!.docs[index]['Date'],
                            name: snapshot.data!.docs[index]['Name'],
                            img: snapshot.data!.docs[index]['Image'],
                            notificationTo: snapshot.data!.docs[index]['NotificationTo'],
                            recievedFrom: snapshot.data!.docs[index]['RecievedBy']));
                      },
                      child: Container(
                        height: 200,
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Text("FileName\n" +
                                        snapshot
                                            .data!
                                            .docs[index]
                                        ['Name']
                                            .toString()),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Date\n" +
                                        snapshot
                                            .data!
                                            .docs[index]
                                        ['Date']
                                            .toString(),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Text("RecievedBy\n" +
                                        snapshot
                                            .data!
                                            .docs[index]
                                        ['RecievedBy']
                                            .toString()),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("NotificationTo\n" +
                                        snapshot
                                            .data!
                                            .docs[index][
                                        'NotificationTo']
                                            .toString())
                                  ],
                                )
                              ],
                            ),
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
    );
  }
}
