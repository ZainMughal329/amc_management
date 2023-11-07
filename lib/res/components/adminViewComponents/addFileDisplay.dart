

import 'package:amc_management/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addFileDisplay extends StatelessWidget {
  final String? imagePath;
  final DateTime? date;
  final String receiverName;
  final String fileNumber;
  final String fileName;
  final String deptName;

   addFileDisplay({super.key,
     this.imagePath,
     this.date,
     required this.receiverName,
     required this.fileNumber,
     required this.fileName,
     required this.deptName,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        // elevation: 4,
        color: AppColors.elevatedButtonColour,// Add shadow to the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Round the corners
        ),
        margin: EdgeInsets.all(16.0), // Margin around the card

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'File Name: $fileName',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          '$deptName',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Receiver Name: $receiverName',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          ' $fileNumber',
                          style: TextStyle(fontSize: 16.0),
                        ),

                      ],
                    )
                    // Text(
                    //   'Date: $date',
                    //   style: TextStyle(fontSize: 16.0),
                    // ),




                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
