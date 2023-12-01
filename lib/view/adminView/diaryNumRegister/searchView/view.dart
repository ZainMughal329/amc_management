


import 'package:amc_management/view/adminView/diaryNumRegister/searchView/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
import '../../../../res/components/adminViewComponents/custom_button.dart';

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
              final timeDate = int.parse(
                item['Id'].toString(),
              );
              final now = DateTime.fromMillisecondsSinceEpoch(timeDate);
              final formattedDate = DateFormat('dd-MM-yy').format(now);
              print('date:' + formattedDate.toString());
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
                        _buildListTile(icon: Icons.numbers_outlined, title: 'Serial Number', content:  item
                        ['serialNum']),
                        _buildListTile(icon: Icons.date_range_outlined, title: 'Date', content:formattedDate),
                        _buildListTile(icon: Icons.date_range_outlined, title: 'File Dispatch Date', content:formattedDate),
                        _buildListTile(icon:Icons.cabin , title: 'Department', content:item
                        ['Dept'], ),
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
                                // Get.to(() =>
                                //     receivedFileShowContainer(
                                //         date: formattedDate,
                                //         id: item
                                //         ['Id'],
                                //         receiverAddress: item['receivedAddress'],
                                //         receiverName: item['receiverName'],
                                //         dept: item
                                //         ['dept'],
                                //         serialNum: item
                                //         ['FileNum'],
                                //         receivedFrom: item['From']));
                              } ),
                              ReuseButton(
                                  icon: Icons.delete_forever,
                                  tittle: 'Delete', onpress: (){
                                final id =item['Id'];
                                controller.deleteFile(id);
                              })
                            ],
                          ),
                        ),
                        // Container(
                        //   color: Color(0xffBEC3C7),
                        //   width: 80,
                        //   height: 40,
                        //   child: TextButton(
                        //       onPressed: () {
                        //
                        //       },
                        //       child: Text(
                        //         'Details',
                        //         style: TextStyle(
                        //             color: AppColors
                        //                 .buttonColour),
                        //       )),
                        // ),
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
  }}