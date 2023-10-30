import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../../../res/components/adminViewComponents/fileShowScreen.dart';

class addFileShowContainer extends StatelessWidget {
  final  String img;
  String fileNum;
  String name;
  String from;
  String date;
  String dept;
  String details;
  addFileShowContainer({
    super.key,
    required this.date,
    required this.name,
    required this.fileNum,
    required this.from,
    required this.dept,
    required this.details,
     required this.img,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      resizeToAvoidBottomInset: false,
      body: BeautifulCard(imagePath: img,
          date: date,
          receiverFrom: from,
          fileNumber: fileNum,
          fileName: name,
          deptName: dept,
          fileDetails: details),
    );
  }
}

//    FileShowContainer({super.key,
