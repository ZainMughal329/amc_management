import 'package:amc_management/view/home/addFile/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class addFileShowContainer extends StatelessWidget {
  // final  String img;
   String fileNum;
   String name;
   String from;
   String date;
   addFileShowContainer({super.key,
    required this.date,
    required this.name,
    required this.fileNum,
    required this.from,
    // required this.img,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(child: Text(name,style: TextStyle(fontSize: 30),)),
                SizedBox(height: 20,),
                Center(child: Text(from)),
                SizedBox(height: 20,),
                Center(child: Text(date)),
                SizedBox(height: 20,),
                Center(child: Text(fileNum.toString())),

              ],
            ),
          )),
    );
  }
}


//    FileShowContainer({super.key,

