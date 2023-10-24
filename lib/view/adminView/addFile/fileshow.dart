import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addFileShowContainer extends StatelessWidget {
  // final  String img;
  String fileNum;
  String name;
  String from;
  String date;
  addFileShowContainer({
    super.key,
    required this.date,
    required this.name,
    required this.fileNum,
    required this.from,
    // required this.img,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(alignment: Alignment.center, children: [
          // Image(image: NetworkImage(i)),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: 300,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  from,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(fileNum.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

//    FileShowContainer({super.key,
