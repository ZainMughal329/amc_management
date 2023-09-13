import 'dart:typed_data';

import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/scanimages/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:get/get.dart';

class ScannImageView extends GetView<ScanImageController> {
  const ScannImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: DocumentScanner(
          controller: controller.state.Doccontroller,
          cropPhotoDocumentStyle: CropPhotoDocumentStyle(
            top: MediaQuery.of(context).padding.top,
          ),
          generalStyles: const GeneralStyles(
            baseColor: Colors.white,
          ),
          onSave: (Uint8List imageBytes) {
            print(imageBytes.toString());
            Get.toNamed(RouteNames.scanImage);
          },
        ),
      ),
    );
  }
}
