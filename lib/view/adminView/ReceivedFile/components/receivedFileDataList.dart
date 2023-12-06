










import 'package:amc_management/res/components/SessionViewComponents/elevated_button.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_button.dart';
import 'package:amc_management/res/components/adminViewComponents/custom_card_widget.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../res/colors.dart';
import 'receivedfileshow.dart';
import '../index.dart';

class receivedFileDataList extends GetView<receivedFileController> {
  const receivedFileDataList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 110,top: 0),
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
                                          _buildListTile(icon: Icons.numbers_outlined, title: 'Serial Number', content:  snapshot.data!.docs[index]
                                          ['serialNum']),
                                          _buildListTile(icon: Icons.date_range_outlined, title: 'Date', content:formattedDate),
                                          _buildListTile(icon:Icons.cabin , title: 'Department', content:snapshot.data!.docs[index]
                                          ['dept'], ),
                                          _buildListTile(icon: Icons.person_outlined, title: 'Received From', content: snapshot.data!.docs[index]
                                          ['receivedFrom']),


                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [

                                              ReuseButton(
                                                  icon: Icons.details_outlined,
                                                  tittle: 'Details', onpress:(){
                                                Get.to(() =>
                                                    receivedFileShowContainer(
                                                        date: formattedDate,
                                                       receiverName: snapshot.data!.docs[index]['receiverName'],
                                                        receiverAddress: snapshot.data!.docs[index]['receivedAddress'],
                                                        id: snapshot.data!.docs[index]
                                                        ['Id'],
                                                        // dept: snapshot
                                                        //     .data!
                                                        //     .docs[index]
                                                        // ['dept'],
                                                        serialNum: snapshot
                                                            .data!
                                                            .docs[index]
                                                        ['serialNum'],
                                                        receivedFrom: snapshot
                                                            .data!
                                                            .docs[index]['receivedFrom']));
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
                  Get.toNamed(RouteNames.searchView);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColour,
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

