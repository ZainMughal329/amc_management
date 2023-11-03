import 'package:amc_management/view/adminView/addFile/index.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';


class ListOfFileView extends StatelessWidget {
  String FileName, date, deptName, details, recieverName, fileNo;

  ListOfFileView({
    Key? key,
    required this.FileName,
    required this.fileNo,
    required this.details,
    required this.date,
    required this.recieverName,
    required this.deptName,
  }) : super(key: key);
  final con = Get.put<addFileController>(addFileController());


  final controller = MultiImagePickerController(
    maxImages: 10,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  Future<void> uploadImages(var images) async {
    // FirebaseStorage storage = FirebaseStorage.instance;
    for (var image in images) {
      String fileName = image.name;
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
        child: Column(
          children: [
            MultiImagePickerView(
              onChange: (list) {
                // debugPrint("Path"+list.toString());
              },
              controller: controller,
              padding: const EdgeInsets.all(10),
            ),
            const SizedBox(height: 32),
            // const CustomExamples()
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Multi Image Picker View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_upward),
            onPressed: () {
              final images = controller.images;
              // use these images
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(images.map((e) => e.name).toString())));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String docId = DateTime.now().millisecondsSinceEpoch.toString();
          int imageId = con.state.imageNo.value;
          // uploadImages(controller.images);
          // print(controller.images.length.toString());
          print('object213');
          // await con.addFileDataOnFirebase(
          //     docId, FileName, date, fileNo, deptName, recieverName, details);
          print('object265413');

          for (var data in controller.images) {
            print(imageId);
            String timestamp =
                DateTime.timestamp().microsecondsSinceEpoch.toString();
            con.uploadimagelistonDatabase(imageId, docId, timestamp, data.path);
            print(imageId.toString() + "after code");
            con.state.imageNo.value++;
          }
          con.state.imageNo.value = 0;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
