

import 'package:amc_management/view/SearchView/dispatchFileSearchView/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../res/colors.dart';
import '../../adminView/dispatchFile/dispatchfileshow.dart';

class dispatchSearchView extends GetView<dispatchSearchController> {
  const dispatchSearchView({super.key});
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
                    // elevation: 4,
                    color: AppColors
                        .buttonColour, // Add shadow to the card
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
                                      item
                                      ['Name'],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                    Spacer(),
                                    // Text(
                                    //
                                    //   item
                                    //   ['Dept'],
                                    //   style: TextStyle(
                                    //       fontSize: 16.0,
                                    //       color: Colors.white),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item
                                      ['RecievedBy'],
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white),
                                    ),
                                    Spacer(),
                                    Text(
                                      item
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
                                    Container(
                                      color: Color(0xffBEC3C7),
                                      width: 80,
                                      height: 40,
                                      child: TextButton(
                                          onPressed: () {
                                            Get.to(() =>
                                                dispatchFileShowContainer(
                                                  date: formattedDate,
                                                  serialNum: item['serialNum'],
                                                  letterNum: item['letterNum'],
                                                  // Dept: item['Dept'],
                                                  id: item['Id'],
                                                  recieverName: item
                                                  ['RecievedBy'],
                                                  // date: formattedDate,
                                                  receiverAddress: item
                                                  ['Name'],
                                                  subject: item[
                                                  'NotificationTo'],
                                                ));
                                          },
                                          child: Text(
                                            'Details',
                                            style: TextStyle(
                                                color: AppColors
                                                    .buttonColour),
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
