import 'dart:io';

import 'package:amc_management/res/components/SessionViewComponents/custom_tetxField.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../model/ReceivedFile_model/ReceivedFile_model.dart';
import '../../../../res/colors.dart';
import 'state.dart'; // Alias the dio package

class receivedFileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final state = receivedFileState();
  late TabController tabController;

  receivedFileController();





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    // for image list
    // getImageUrls().then((urls) => {state.imageUrls = urls});
  }



  final picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;

  Future pickCameraImage(BuildContext context) async {
    final image =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (image != null) {
      _image = XFile(image.path);
      update();
    }
  }

  Future pickGalleryImage(BuildContext context) async {
    final image =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (image != null) {
      _image = XFile(image.path);
      update();
    }
  }

  // Future uploadimageonDatabase(String timeStamp) async {
  //   firebase_storage.Reference storageRef =
  //   firebase_storage.FirebaseStorage.instance.ref('/Received Files' + timeStamp);
  //   firebase_storage.UploadTask uploadTask =
  //   storageRef.putFile(File(image!.path).absolute);
  //   await Future.value(uploadTask);
  //   final imageUrl = await storageRef.getDownloadURL();
  //   state.ref.doc(timeStamp).update({
  //     'image': imageUrl,
  //   }).then((value) {
  //     print('File uploaded and stored');
  //   });
  // }

  void pickImage(context) {
    Get.dialog(AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                pickCameraImage(context);
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
                pickGalleryImage(context);
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

//   Future<void> uploadReceivedFileOnFirebase(
//
//       String timeStamp,
//       // String dept,
//       String image,
//       String date,
//       String serialNum,
//       String receivedfrom,
//       String receivereName,
//       String receivereAddress
//       ) async {
//     setLoading(true);
//     try {
//       await state.ref.doc(timeStamp).set({
//
//         // 'Dept': dept,
//         // 'Name': name,
//         'receivedFrom': receivedfrom,
//         'receivedAddress':receivereAddress,
//         'receiverName':receivereName,
//         'FileNum': serialNum,
//         'Date': date,
//       }).then((value) {
//         setLoading(false);
//         Get.snackbar('Success', 'File Added');
//         // Get.back();
//       }).onError((error, stackTrace) {
//         setLoading(false);
//         Get.snackbar('Error', error.toString());
//       });
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }
//
//   void storeData(
//       String timeStamp,
//       ReceivedFileModel addFile,
//       BuildContext context,
//       // String name,
//       // String dept,
//       String image,
//       String date,
//       String serialNum,
//       String receivedfrom,
//       String receiverAddress,
//       String receivereName,
//       ) async {
//     setLoading(true);
//     uploadReceivedFileOnFirebase( timeStamp,
//         // dept,
//         image, date, serialNum, receivedfrom,receiverAddress,receivereName)
//         .then((value) {
//       uploadimageonDatabase(timeStamp);
//       setLoading(false);
//       clearDateFromScreen();
//     }).onError((error, stackTrace) {
//       setLoading(false);
//       Get.snackbar('Error', error.toString());
//     });
//   }
//
//
//
//
//
//   Stream<DocumentSnapshot<Map<String, dynamic>>> getFIleData() {
//     return state.ref.doc(state.auth.currentUser!.uid.toString()).snapshots();
//   }
//
// //   here we create function to vaLidate THE FORM
//
//   void validateForm() {
//     state.isFormValid.value =
//         state.dateController.text.isNotEmpty &&
//             state.serialNumController.text.isNotEmpty &&
//             state.receivedfromController.text.isNotEmpty &&
//             state.detailController.text.isNotEmpty ;
//     // state.deptName.value.isNotEmpty;
//   }



//   here we manage the section of update the file data

  // Future<void> showFileNameDialogAlert(
  //     BuildContext context, String filename, String id) {
  //   //this line 104 code mean jo user ka already name ho ga wo show ho
  //   state.nameController.text = filename;
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Center(child: Text('update filename')),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 ReuseField(
  //                     myController: state.nameController,
  //                     focusNode: state.nameFocusNode,
  //                     lableText: 'Enter your Filename',
  //                     onFiledSubmittedValue: (value) {},
  //                     keyboardType: TextInputType.emailAddress,
  //                     obsecureText: false,
  //                     onvalidator: (value) {})
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   'cancel',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .subtitle2!
  //                       .copyWith(color: AppColors.warningColor),
  //                 )),
  //             TextButton(
  //                 onPressed: () {
  //                   print('id' + id);
  //                   //this  code will update the name in database
  //                   state.ref.doc(id).update({
  //                     'Name': state.nameController.text.toString()
  //                   }).then((value) {
  //                     fetchDataOfFiles(id);
  //                     state.nameController.clear();
  //                   });
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   'ok',
  //                   style: Theme.of(context).textTheme.subtitle2,
  //                 ))
  //           ],
  //         );
  //       });
  // }






//   here we create a function to delelete files




}
