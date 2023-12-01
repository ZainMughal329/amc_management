import 'package:amc_management/view/adminView/diaryNumRegister/listOfImages/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class listOfImagesView extends GetView<listOfImagesController> {
  listOfImagesView({super.key});
  final con = MultiImagePickerController(
    maxImages: 10,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Images'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [Column(
            children: [
              MultiImagePickerView(

                  onChange: (list){

                  },
                  controller: con,
                  padding: const EdgeInsets.all(10)
              ),
              const SizedBox(height: 32),
            ],
          )],
        ),
      ),
    );
  }
}
