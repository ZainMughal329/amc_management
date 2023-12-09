import 'package:amc_management/view/adminView/ReceivedFile/receivedFileUploadForm/controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../../res/colors.dart';
import 'controller.dart';


class ListOfFileView extends GetView<listOfImagesController> {
  String
  // deptName,
  details, recieverName, fileNo;
  final DateTime date;
  ListOfFileView({
    Key? key,
    // required this.FileName,
    required this.fileNo,
    required this.details,
    required this.date,
    required this.recieverName,
    // required this.deptName,
  }) : super(key: key);
  final controller = listOfImagesController();
  final uploadFormCon=uploadFormController();
  final con = MultiImagePickerController(
    maxImages: 10,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  Future<void> uploadImages(var images) async {
    // FirebaseStorage storage = FirebaseStorage.instance;
    for (var image in images) {
      String fileName = image.senderAddress;
      print("File name is" + fileName.toString());
      // Reference ref = storage.ref().child('your_directory_name/$fileName');
      // ByteData byteData = await image.data;
      // List<int> imageData = byteData.buffer.asUint8List();
      try {
        // await ref.putData(imageData);
        // print('Uploaded $fileName successfully');
      } catch (e) {
        // print('Failed to upload $fileName. Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                MultiImagePickerView(
                  onChange: (list) {
                    // debugPrint("Path"+list.toString());
                  },
                  controller: con,
                  padding: const EdgeInsets.all(10),
                ),
                const SizedBox(height: 32),
                // const CustomExamples()
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: ()async {
                    String docId = DateTime.now().millisecondsSinceEpoch.toString();
                    int imageId = controller.state.imageNo.value;
                    for (var data in con.images) {
                      print(imageId);
                      String timestamp =
                      DateTime.timestamp().microsecondsSinceEpoch.toString();
                      uploadFormCon.uploadimagelistonDatabase(imageId, docId, timestamp, data.path);
                      print(imageId.toString() + "after code");
                      controller.state.imageNo.value++;
                    }
                    controller.state.imageNo.value = 0;
                  },
                  child:  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.buttonColour,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(() => Center(
                        child: controller.state.loading.value == false ? Text('Upload Images' , style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),) : CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                ),

              ),
            ),

          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Select Images'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.arrow_upward),
          //   onPressed: () {
          //     final images = controller.images;
          //     // use these images
          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //         content: Text(images.map((e) => e.name).toString())));
          //   },
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     String docId = DateTime.now().millisecondsSinceEpoch.toString();
      //     int imageId = con.state.imageNo.value;
      //
      //     for (var data in controller.images) {
      //       print(imageId);
      //       String timestamp =
      //           DateTime.timestamp().microsecondsSinceEpoch.toString();
      //       con.uploadimagelistonDatabase(imageId, docId, timestamp, data.path);
      //       print(imageId.toString() + "after code");
      //       con.state.imageNo.value++;
      //     }
      //     con.state.imageNo.value = 0;
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
