

import 'package:flutter/material.dart';
class dispatchFileShowContainer extends StatelessWidget {
  String notificationTo;
  String img;
  String name;
  String recievedFrom;
  String date;
  
   dispatchFileShowContainer({super.key,
    required this.date,
    required this.name,
    required this.notificationTo,
    required this.recievedFrom,
     required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  child: Image(image: NetworkImage(img)),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(child: Text(name,style: TextStyle(fontSize: 30),)),
                SizedBox(height: 20,),
                Center(child: Text(recievedFrom)),
                SizedBox(height: 20,),
                Center(child: Text(date)),
                SizedBox(height: 20,),
                Center(child: Text(notificationTo)),

              ],
            ),
          )),
    );
  }
}
