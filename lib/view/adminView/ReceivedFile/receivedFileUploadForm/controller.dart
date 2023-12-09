




import 'dart:io';

import 'package:amc_management/view/adminView/ReceivedFile/listOfImages/state.dart';
import 'package:amc_management/view/adminView/ReceivedFile/listOfImages/view.dart';
import 'package:amc_management/view/adminView/ReceivedFile/receivedFileUploadForm/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../../model/ReceivedFile_model/ReceivedFile_model.dart';
import '../../../../utils/routes/routes_name.dart';

class uploadFormController extends GetxController{
  final state = dataUploadState();
  final st = listOfImagestate();
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();
  void setLoading(value) {
    state.loading.value = value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.dateController.dispose();
    state.serialNumController.dispose();
    state.receivedfromController.dispose();
    state.detailFocusNode.dispose();
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

  Future<void> uploadReceivedFileDataOnFirebase(
      String id,
      // String name,
      final DateTime date,
      String serialNum,
      // String deptName,
      String receiverName,
      String receiverAddress,
      String recieverFrom,
      ) async {
    try {
      setLoading(true);
      print('inside try');
      await state.ref
          .doc(id)
          .set(ReceivedFileModel(
        id: id,
        images: [],
        // name: name,
        // dept: deptName,
        date: date,
        receivedAddress: receiverAddress,
        receivereName: receiverName,
        receivedFrom: recieverFrom,
        SerialNum: serialNum,
      )
          .toJson())
          .then((value) {
        print('inside then');
        Get.to(() => ListOfFileView(
          details: state.detailController.text
              .trim(),
          date:state.selectedDate,
          fileNo: state.serialNumController.text
              .trim(),
          recieverName:
          state.receivedfromController.text.trim(),
          // FileName:
          // state.nameController.text.trim(),
          // deptName: state.deptName.value,
        ));

        setLoading(false);

      }).onError((error, stackTrace) {
        print("Error" + error.toString());

        setLoading(false);

      });
    } catch (e) {
      setLoading(false);

    }}
  Future<void> uploadimagelistonDatabase (
      int imageId, String docId, String timeStamp, var imagePath) async {
    final imageUrl;
    try {
      setLoading(true);
      firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref('/Received Files' + timeStamp);
      firebase_storage.UploadTask uploadTask =
      storageRef.putFile(File(imagePath).absolute);
      await Future.value(uploadTask);
      imageUrl = await storageRef.getDownloadURL();
      // List<String> imageUrls = imageUrl;
      print('img 12' + imageUrl.toString());
      print('id Is : ' + documentId);
      await state.ref.doc(documentId).update(
        {
          'images': FieldValue.arrayUnion([imageUrl]),
          // imageId.toString() : imageUrl,
        },

        // SetOptions(merge: false),
      ).then((value) {
        print("image no is" + imageId.toString());
        print("image url is" + imageUrl.toString());
         clearDateFromScreen();
        // images = [];
        Get.toNamed(RouteNames.homeview);

        setLoading(false);

      }).onError((error, stackTrace) {
        print(error.toString());
        setLoading(false);

      });
    } catch (e) {
      print(e.toString());
      setLoading(false);

    }
  }

clearDateFromScreen() {

  state.dateController.clear();
  state.receivedfromController.clear();
  // state.nameController.clear();
  state.serialNumController.clear();
  // state.deptName.value = "Select";
  state.detailController.clear();
  state.receiverAddressController.clear();
  state.receiverNameController.clear();
  st.images=[];
}



}