import 'dart:typed_data';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/scanimages/controller.dart';
// import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
// import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:get/get.dart';

class ScannImageView extends GetView<ScanImageController> {
   ScannImageView({super.key});

  List<String> _pictures = [];

  @override
  Widget build(BuildContext context) {
    // return  Scaffold(
    //   body: SafeArea(
    //     child: DocumentScanner(
    //       controller: controller.state.Doccontroller,
    //       cropPhotoDocumentStyle: CropPhotoDocumentStyle(
    //         top: MediaQuery.of(context).padding.top,
    //       ),
    //       generalStyles: const GeneralStyles(
    //         baseColor: Colors.white,
    //       ),
    //       onSave: (Uint8List imageBytes) {
    //         print(imageBytes.toString());
    //         Get.toNamed(RouteNames.scanImage);
    //       },
    //     ),
    //   ),
    // );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Plugin example app'),
    //   ),
    //   body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           ElevatedButton(
    //               onPressed: ()async{
    //                 List<String> pictures;
    //                 try {
    //                   pictures = await CunningDocumentScanner.getPictures() ?? [];
    //
    //                   print(pictures.toString());
    //                   // if (!mounted) return;
    //                   // setState(() {
    //                   //   _pictures = pictures;
    //                   // });
    //                 } catch (exception) {
    //                   // Handle exception here
    //                 }
    //
    //
    //               },
    //               child: const Text("Add Pictures")),
    //           for (var picture in _pictures) Image.file(File(picture))
    //         ],
    //       )),
    // );
return Scaffold();
  }
}
