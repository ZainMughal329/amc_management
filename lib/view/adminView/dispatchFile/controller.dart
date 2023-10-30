import 'dart:io';

import 'package:amc_management/res/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage ;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'index.dart';
import 'package:amc_management/model/dispatch_model/dispatch_model.dart';
class dispatchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final state = dispatchState();
  late TabController tabController;
  dispatchController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.nameController.dispose();
    // state.dateController.dispose();
    state.notificationToController.dispose();
    state.recievedByController.dispose();
    state.detailController.dispose();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
  final picker =ImagePicker();
  XFile? _image;
  XFile? get image=>_image;

  void pickedImageFromGallery(
      BuildContext context,
      ) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      update();
    }
  }
  void pickedImageFromCamera(
      BuildContext context,
      ) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      update();
    }
  }
  Future uploadimageonDatabase (String timeStamp) async{
    firebase_storage.Reference storageRef =firebase_storage.FirebaseStorage.instance.ref('/dispatchFile'+timeStamp);
    firebase_storage.UploadTask uploadTask =storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final imageUrl = await storageRef.getDownloadURL();
    state.ref.doc(timeStamp).update({
      'Image': imageUrl,
    }).then((value){
      print('File uploaded and stored');
    });

  }

  void pickImage(context) {
    Get.dialog(AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                pickedImageFromCamera(context);
                Get.back();
              },
              title: Text('Camera'),
              leading: Icon(
                Icons.camera,
                color: AppColors.lightActiveIconColor,
              ),
            ),
            ListTile(
              onTap: () {
                pickedImageFromGallery(context);
                Get.back();
              },
              title: Text('Gallery'),
              leading: Icon(
                Icons.image,
                color: AppColors.lightActiveIconColor,
              ),
            ),
          ],
        ),
      ),
    ));
  }




  Future<void> DispatchModelFile(String detail,String timeStamp,String name, String image, String date,
      String recievedBy,
      String dept,
      String notificationTo) async {
    try {
      await state.ref.doc(timeStamp).set({
        'Detail':detail,
        'Image': image,
        'Name': name,
        'Dept':dept,
        'RecievedBy': recievedBy,
        'NotificationTo': notificationTo,
        'Date': date,
      }).then((value) {
        Get.snackbar('Sucess', 'File Uploaded');
        Get.back();
      }).onError((error, stackTrace) {
        Get.snackbar('Error', error.toString());
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  void storeData(
      String timeStamp,
      DispatchModel dispatch,
      BuildContext context,
      String detail,
      String image,
      String name,
      String dept,
      String recievedBy,
      String notificationTo,
      String date) async {
    DispatchModelFile(detail,timeStamp,name, image,dept, date, recievedBy, notificationTo)
        .then((value) {
          clearDateFromScreen();
    });
  }
  clearDateFromScreen(){
    state.dateController.clear();
    state.recievedByController.clear();
    state.nameController.clear();
    state.notificationToController.clear();
    state.deptName="".obs;
    state.detailController.clear();
    // imagePath.value="";
  }

  getDateFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1978),
        lastDate: DateTime(2099));
    if (pickerDate != null) {
      state.selectedDate = pickerDate;
      update();
    } else {
      print('select a date ');
    }
  }
}
