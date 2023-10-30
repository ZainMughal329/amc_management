import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../utils/snackBar.dart';
class BeautifulCard extends StatelessWidget {
  final String imagePath;
  final String date;
  final String receiverFrom;
  final String fileNumber;
  final String fileName;
  final String deptName;
  final String fileDetails;

  BeautifulCard({
    required this.imagePath,
    required this.date,
    required this.receiverFrom,
    required this.fileNumber,
    required this.fileName,
    required this.deptName,
    required this.fileDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image
              Stack(
                children: <Widget>[
                  Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 400.0,
                  ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: IconButton(
                      icon: Icon(Icons.download, color: Colors.black38),
                      onPressed: () async{
                        // Define the path to the image you want to save
                        final imageBytes = await rootBundle.load(imagePath);

                        // Save the image to the gallery
                        await ImageGallerySaver.saveImage(Uint8List.sublistView(imageBytes.buffer.asUint8List()));
                        SnackBar(content: Text('Image Save To Gallery'));
                        // Handle download action here
                      },
                    ),
                  ),
                ],
              ),

              // Other attributes
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AttributeText(label: 'File Name', value: fileName),
                    AttributeText(label: 'Date', value: date),
                    AttributeText(label: 'File Number', value: fileNumber),
                    AttributeText(label: 'Received From', value: receiverFrom),
                    AttributeText(label: 'Department Name', value: deptName),

                    SizedBox(height: 16.0),

                    FileDetailsText(fileDetails: fileDetails),
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

class AttributeText extends StatelessWidget {
  final String label;
  final String value;

  AttributeText({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $value',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    );
  }
}

class FileDetailsText extends StatelessWidget {
  final String fileDetails;

  FileDetailsText({required this.fileDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'File Details',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        Text(
          fileDetails,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
