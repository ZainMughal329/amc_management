

import 'package:amc_management/res/components/adminViewComponents/fileShowScreen.dart';
import 'package:flutter/material.dart';
class dispatchFileShowContainer extends StatelessWidget {
  String notificationTo;
  String recievedBy;
  String img;
  String name;
  String details;
  String date;
   dispatchFileShowContainer({super.key,
    required this.date,
    required this.name,
    required this.details,
     required this.recievedBy,
     required this.notificationTo,
     required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      resizeToAvoidBottomInset: false,

      body: BeautifulCard(imagePath: img,
          date: date,
          receiverFrom: recievedBy,  fileName: name,
          fileDetails: details),
    );
  }
}
