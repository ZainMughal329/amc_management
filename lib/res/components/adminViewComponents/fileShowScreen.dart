import 'package:amc_management/view/adminView/addFile/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../utils/snackBar.dart';
class BeautifulCard extends StatelessWidget {
    String? imagePath;
   String? date;
  final String receiverFrom;
  final String fileNumber;
  final String fileName;
  final String deptName;
  final String fileDetails;

  BeautifulCard({
    this.imagePath='',
     this.date,
    required this.receiverFrom,
    this.fileNumber='',
    required this.fileName,
     this.deptName='',
    required this.fileDetails,
  });

  @override
  Widget build(BuildContext context) {
    final state = addFileState();
    return Center(
      child: IntrinsicHeight(
        child: Card(
          // elevation: 4,
          margin: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
            child: ListView.builder(
              itemCount: state.imageUrls.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: state.imageUrls[index],
                  placeholder: (context, url) => CircularProgressIndicator(), // Show a loading indicator
                  errorWidget: (context, url, error) => Icon(Icons.error), //
                  // Show an error icon if the image fails to load
                );
              },
            ),
                // Image
                // Stack(
                //   children: <Widget>[
                //     Image.network(
                //       imagePath!,
                //       fit: BoxFit.cover,
                //       width: double.infinity,
                //       height: 400.0,
                //     ),
                //     Positioned(
                //       top: 8.0,
                //       right: 8.0,
                //       child: IconButton(
                //         icon: Icon(Icons.download, color: Colors.black38),
                //         onPressed: () async{
                //           // Define the path to the image you want to save
                //           final imageBytes = await rootBundle.load(imagePath!);
                //
                //           // Save the image to the gallery
                //           await ImageGallerySaver.saveImage(Uint8List.sublistView(imageBytes.buffer.asUint8List()));
                //           SnackBar(content: Text('Image Save To Gallery'));
                //           // Handle download action here
                //         },
                //       ),
                //     ),
                //   ],
                // ),

                // Other attributes

          ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AttributeText(label: 'File Name', value: fileName),
                    AttributeText(label: 'Date', value: date!),
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
