
import 'dart:io';

// import 'package:document_scanner_flutter/configs/configs.dart';
// import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScannImageView extends GetView<ScannImageView> {
   ScannImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();// return Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: TextButton(
    //         onPressed: () async{
    //           try {
    //             File? scannedDoc = await DocumentScannerFlutter.launchForPdf(context, source: ScannerFileSource.CAMERA);
    //             if(scannedDoc!=null){
    //               print(scannedDoc.absolute.toString());
    //             }
    //             // Or ScannerFileSource.GALLERY
    //             // `scannedDoc` will be the PDF file generated from scanner
    //           } on PlatformException {
    //             // 'Failed to get document path or operation cancelled!';
    //           }
    //         },
    //         child: Text("Scan"),
    //       ),
    //     ),
    //   ),
    // );
  }
}
