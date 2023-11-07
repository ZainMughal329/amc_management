import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String? imagePath;
  final DateTime? date;
  final String receiverName;
  final String fileNumber;
  final String fileName;
  final String deptName;

  CustomCardWidget({
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
        elevation: 4, // Add shadow to the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Round the corners
        ),
        margin: EdgeInsets.all(16.0), // Margin around the card

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display the image
            // Image.network(
            //   imagePath,
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            //   height: 150.0, // Adjust the height as needed
            // ),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date: $date',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Receiver Name: $receiverName',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'File Number: $fileNumber',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'File Name: $fileName',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Dept Name: $deptName',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
