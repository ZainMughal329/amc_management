import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../model/services/session_Controller.dart';
import '../../../model/userModel/user_model.dart';
import '../../../res/components/UserViewComponents/userApprovalPage.dart';
import '../../../utils/routes/routes_name.dart';
import '../../../utils/snackBar.dart';
import '../../res/colors.dart';
import '../adminView/addFile/components/addfileshow.dart';
import 'index.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SearchView extends GetView<SearchBarController> {
  SearchView({super.key});

  _searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: GetBuilder<SearchBarController>(
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

              hintText: 'Search items here...',
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
          Expanded(child: Obx(() => controller.filteredFiles.length != 0 ?
              ListView.builder(
                itemCount: controller.filteredFiles.length,
                itemBuilder: (context , index) {
                  final item =controller.filteredFiles[index];
                  final timeDtae = int.parse(item['Id'].toString(),);
                  final now = DateTime.fromMillisecondsSinceEpoch(timeDtae);
                  final formattedDate = DateFormat('dd-MM-yy').format(now);
                  print('date:' + formattedDate.toString());
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
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
                                        item
                                        ['Name'],
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      Spacer(),
                                      Text(
                                        item
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
                                        item
                                        ['From'],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white),
                                      ),
                                      Spacer(),
                                      Text(
                                        item
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
                                                      name: item
                                                      ['Name'],
                                                      id: item
                                                      ['Id'],
                                                      dept: item
                                                      ['dept'],
                                                      details: item
                                                      ['Detail'],
                                                      fileNum: item
                                                      ['FileNum'],
                                                      from: item['From']));
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
                    ),
                  );
                },
              )
              : Container(
            child: Center(child: Text('No searches yet' , style: TextStyle(fontSize: 25),)),
          )),),
        ],
      ),
    );
  }
}
