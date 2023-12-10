import 'package:amc_management/view/adminView/diaryNumRegister/dataUplaodForm/controller.dart';
import 'package:amc_management/view/adminView/diaryNumRegister/listOfImages/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import '../../../../res/colors.dart';

class listOfImagesView extends GetView<listOfImagesController> {
  String serialNum,subjectOfFile,senderName,senderAddress,receiverName;
  List<String> deptName;
   DateTime? date;
   DateTime? filedispatchDate;
  listOfImagesView({super.key,
  required this.serialNum,
    required this.subjectOfFile,
    required this.senderName,
    required this.senderAddress,
    required this.receiverName,
    required this.deptName,
     this.date,
     this.filedispatchDate,
  });
  final uplaodFormCon = Get.put<dataUplaodController>(dataUplaodController());
  final con = MultiImagePickerController(
    maxImages: 10,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Select Images'),
      // ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                MultiImagePickerView(
                    onChange: (list) {},
                    controller: con,
                    padding: const EdgeInsets.all(10)),
                const SizedBox(height: 32),
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
                      uplaodFormCon.uploadimagelistonDatabase(imageId, docId, timestamp, data.path);
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
                        color: AppColors.filesCardBgColour.withOpacity(0.8),
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
    );
  }
}
