


import 'package:amc_management/view/adminView/diaryNumRegister/searchView/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/custom_button.dart';
import '../allFileDetails/view.dart';

class diarySearchView extends GetView<diaryFilesSearchController> {
   diarySearchView({super.key});
  _searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: GetBuilder<diaryFilesSearchController>(
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
  @override
  Widget build(BuildContext context) {
    final con = Get.put(diaryFilesSearchController());
    return Scaffold(
      appBar: AppBar(
        title: _searchBar(),
      ),
      body: Column(
        children: [
          Expanded(child:
          Obx(()=>controller.filteredFiles.length != 0?
          ListView.builder(
            itemCount: controller.filteredFiles.length,
            itemBuilder: (context, index) {
              final item = controller.filteredFiles[index];
              final Timestamp fileDispatchDateTimestamp = item['fileDispatchDate'];
              final DateTime fileDispatchDate = fileDispatchDateTimestamp.toDate();
              final formattedDate2 = DateFormat('dd-MM-yy').format(fileDispatchDate);
              final idFromDb = int.parse(
                  item['Id'].toString());
              final timeInMilli =
              DateTime.fromMillisecondsSinceEpoch(idFromDb);
              final formattedDate =
              DateFormat('dd-MM-yy').format(timeInMilli);
              print('date is : ' + formattedDate.toString());
              print('Date 1: $formattedDate, Date 2: $formattedDate2');
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
                        _buildListTile(icon: Icons.numbers_outlined, title: 'Serial Number', content:  item
                        ['serialNum']),
                        _buildListTile(icon: Icons.date_range_outlined, title: 'Date', content:formattedDate),
                        _buildListTile(icon: Icons.date_range_outlined, title: 'File Dispatch Date', content:formattedDate2),
                        // _buildListTileForDept(icon:Icons.cabin , title: 'Department', content: snapshot.data!.docs[index]
                        // ['Dept']),
                        _buildListTile(icon: Icons.person_outlined, title: 'Sender Name', content: item
                        ['senderName']),
                        _buildListTile(icon: Icons.person_outlined, title: 'Receiver Name', content: item
                        ['receiverName']),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ReuseButton(
                                  icon: Icons.details_outlined,
                                  tittle: 'Details', onpress:(){
                                Get.to(()=>
                                    diaryFilesDetailView(
                                      serialNum: item
                                      ['serialNum'],
                                      senderName: item
                                      ['senderName'],
                                      senderAddress: item
                                      ['senderAddress'],
                                      receiverName: item
                                      ['receiverName'],
                                      subject: item['subject'],
                                      id: item
                                      ['Id'],
                                      dept: item
                                      ['Dept'],
                                      date: formattedDate,
                                      fileDispatchDate:formattedDate2,
                                    )
                                );

                              }
                              ),
                              ReuseButton(
                                  icon: Icons.delete_forever,
                                  tittle: 'Delete', onpress: (){
                                final id = item['Id'];
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
            },
          ):Container(
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
           leading: Icon(icon, color: AppColors.filesCardTextColour, size: 22),
           title: Text(
             title,
             style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16, color: AppColors.filesCardTextColour)),
           ),
           trailing: Text(
             content,
             style: GoogleFonts.poppins(
                 textStyle: TextStyle(fontSize: 14, color: AppColors.filesCardTextColour)
             ),
           ),
         ),
         SizedBox(height: 4),
       ],
     );
   }}
