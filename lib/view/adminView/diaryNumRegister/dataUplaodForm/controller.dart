import 'dart:io';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/adminView/diaryNumRegister/dataUplaodForm/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../../model/diaryNum_model/diaryNum_model.dart';
import '../../../scanimages/controller.dart';
import '../listOfImages/state.dart';
import '../listOfImages/view.dart';

class dataUplaodController extends GetxController{
  final state = dataUploadState();
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();
  final st = listOfImagesState();

  void setLoading(value) {
    state.loading.value = value;
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
  getDispatchDateFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1978),
        lastDate: DateTime(2099));
    if (pickerDate != null) {
      state.dispatchSelDate = pickerDate;
      update();
    } else {
      print('select a date ');
    }
  }


  Future<void> uploadDiaryNumberFiles(
      String id,
      String serialNum,
      final DateTime date,
      final DateTime filedispatchdate,
      String senderName,
      String receiverName,
      String senderAddress,
      String dept,
      String subjectOfFile,
      )async{
    setLoading(true);
    try{
      await state.ref.doc(id).set(DiaryNumModel(
          id: id,
          images: [],
          dept: state.selectedDepartments.toList(),
          date: date,
          fileDispatchDate: filedispatchdate,
          subject: subjectOfFile,
          senderName: senderName,
          receiverName: receiverName,
          senderAddress: senderAddress,
          serialNum: serialNum).toJson()).then((value){
            Get.to(()=>listOfImagesView(
                serialNum: state.serialNumController.text.trim(),
                subjectOfFile: state.fileSubjectController.text.trim(),
                senderName: state.senderNameController.text.trim(),
                senderAddress: state.senderAddressController.text.trim(),
                receiverName: receiverName,
                date: state.selectedDate,
                filedispatchDate: state.dispatchSelDate,
                deptName: state.selectedDepartments.toList())
            );
            setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
      });
    }catch(e){
      setLoading(false);

    }
  }

  Future<void> uploadimagelistonDatabase(
      int imageId, String docId, String timeStamp, var imagePath) async {
    final imageUrl;
    try {
      setLoading(true);
      firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref('/diaryNumberRegister' + timeStamp);
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
        Get.offAllNamed(RouteNames.homeview);

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
    state.serialNumController.clear();
    state.receiverNameController.clear();
    state.fileSubjectController.clear();
    state.deptName.value = "Select";
    state.fileDispatchDateController.clear();
    state.senderAddressController.clear();
    state.receiverNameController.clear();
    st.images=[];
  }


//   for multiple selected departments

  void showMultiSelectBottomSheet() async {
    List<String> selectedDepartments = await Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
        ),
        child: MultiSelectBottomSheet(state.departments, state.selectedDepartments),
      ),
    );

    if (selectedDepartments != null) {
      state.selectedDepartments.assignAll(selectedDepartments);
      // Send the list to the database or perform any other action here
      print('Selected Items: $state.selectedDepartments');
    }
  }


}