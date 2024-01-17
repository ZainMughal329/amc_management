

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/custom_button.dart';
import '../dispatchFileDetails/dispatchfileshow.dart';
import 'controller.dart';

class dispatchSearchView extends GetView<dispatchSearchController> {
   dispatchSearchView({super.key});
  _searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: GetBuilder<dispatchSearchController>(
        builder: (con) {
          return TextField(
            onChanged: (value) {
              controller.fetchFilteredFiles(value);
              print(
                'length of filtered is : ' +
                    controller.filteredFiles.length.toString(),
              );
            },
            controller: controller.state.searchController,
            textInputAction: TextInputAction.search,

            keyboardType: TextInputType.text,
            cursorColor: AppColors.iconColor,
            // focusNode: focNode,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.iconColor,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.iconColor,
                ),
              ),

              suffixIcon: Icon(
                Icons.search,
                color: AppColors.iconColor,
              ),
              // border: InputBorder.none,

              hintText: 'Search Files here...',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
  final con = Get.put(dispatchSearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBar(),
      ),
      body: Column(
        children: [
          Expanded(child:
          Obx( ()=>
          controller.filteredFiles.length != 0?
              ListView.builder(
                itemCount: controller.filteredFiles.length,
                itemBuilder: (context,index){
                  final item = controller.filteredFiles[index];
                  final timeDate = int.parse(
                    item['Id'].toString(),
                  );
                  final now = DateTime.fromMillisecondsSinceEpoch(timeDate);
                  final formattedDate = DateFormat('dd-MM-yy').format(now);
                  print('date:' + formattedDate.toString());
                  return Card(
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
                          _buildListTile(icon: Icons.numbers_outlined, title: 'Serial Number', content:  item
                          ['serialNum']),
                          _buildListTile(icon: Icons.date_range_outlined, title: 'Date', content:formattedDate),
                          _buildListTile(icon: Icons.person_outlined, title: 'Received Name', content: item
                          ['recieverName']),
                          _buildListTile(icon:Icons.cabin , title: 'Letter Num', content:item
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
                                        recieverName: item['recieverName'],
                                        receiverAddress: item['receiverAddress'],
                                        id: item
                                        ['Id'],
                                        letterNum: item['letterNum'],
                                        // Dept: snapshot
                                        //     .data!
                                        //     .docs[index]
                                        // ['dept'],
                                        subject: item['subject'],
                                        serialNum:item                                        ['serialNum'],


                                      ));
                                } ),
                                ReuseButton(
                                    icon: Icons.delete_forever,
                                    tittle: 'Delete', onpress: (){
                                  final id = item['Id'];
                                  // controller.deleteFile(id);
                                })
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );

                },

              ):
          Container(
            child: Center(
                child: Text(
                  'No searches yet',
                  style: TextStyle(fontSize: 25),
                )),
          )
          )
          )
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
        leading: Icon(icon, color: AppColors.filesCardTextColour.withOpacity(0.8), size: 22),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, color: AppColors.filesCardTextColour.withOpacity(0.8)),
        ),
        trailing: Text(
          content,
          style: TextStyle(fontSize: 14, color: AppColors.filesCardTextColour.withOpacity(0.8)),
        ),
      ),
      SizedBox(height: 4),
    ],
  );
}


