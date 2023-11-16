import 'dart:io';

import 'package:amc_management/res/colors.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/adminView/addFile/components/addFileForm.dart';
import 'package:amc_management/view/adminView/dispatchFile/components/disptachfileUploadForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../res/components/SessionViewComponents/custom_tetxField.dart';
import 'components/listOfImages/listofimages.dart';
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

  DispatchModel? dispatchModel;
  DocumentSnapshot? documentSnapshot;

  fetchDataOfFile(String id) async {
    try {
      documentSnapshot = await FirebaseFirestore.instance
          .collection('dispatchFile')
          .doc(id)
          .get();
      if (documentSnapshot!.exists) {
        dispatchModel = DispatchModel(
            id: id,
            images: images,
            dept: documentSnapshot!['Dept'],
            name: documentSnapshot!['Name'],
            recievedBy: documentSnapshot!['RecievedBy'],
            notificationTo: documentSnapshot!['NotificationTo'],
            filenum: documentSnapshot!['FileNum']);
        state.nameFile.value = documentSnapshot!['Name'];
        state.fileNum.value = documentSnapshot!['FileNum'];
        state.loaded.value = true;
      } else {
        print('empty');
      }
    } catch (e) {
      print('exception : ' + e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  void setLoading(value) {
    state.loading.value = value;
  }

  final picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;
  List<String> images = [];
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();

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

  Future uploadimageonDatabase(String timeStamp) async {
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/dispatchFile' + timeStamp);
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final imageUrl = await storageRef.getDownloadURL();
    state.ref.doc(timeStamp).update({
      'Image': imageUrl,
    }).then((value) {
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

  Future<void> DispatchModelFile(
      String detail,
      String timeStamp,
      String name,
      String image,
      String date,
      String recievedBy,
      String dept,
      String notificationTo) async {
    try {
      await state.ref.doc(timeStamp).set({
        'Detail': detail,
        'Image': image,
        'Name': name,
        'Dept': dept,
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
    DispatchModelFile(detail, timeStamp, name, image, dept, date, recievedBy,
            notificationTo)
        .then((value) {
      clearDateFromScreen();
    });
  }

  clearDateFromScreen() {
    state.dateController.clear();
    state.recievedByController.clear();
    state.nameController.clear();
    state.notificationToController.clear();
    state.deptName = "".obs;
    state.detailController.clear();
    images =[];
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

  void validateForm() {
    state.isFormValid.value = state.nameController.text.isNotEmpty &&
        state.dateController.text.isNotEmpty &&
        state.recievedByController.text.isNotEmpty &&
        state.notificationToController.text.isNotEmpty &&
        state.detailController.text.isNotEmpty &&
        state.deptName.value.isNotEmpty;
  }

  Future uploadimagelistonDatabase(
      int imageId, String docId, String timeStamp, var imagePath) async {
    setLoading(true);
    final imageUrl;
    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref('/dispatchFile' + timeStamp);
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
    }
  }

  Future<void> dispatchfileDataOnFirebase(
      String fileNum,
      String id,
      String name,
      final DateTime date,
      String recievedBy,
      String deptName,
      String notificationTo,
      String details) async {
    try {
      setLoading(true);

      print('inside try');
      await state.ref
          .doc(id)
          .set(DispatchModel(
                  filenum: fileNum,
                  id: id,
                  images: [],
                  name: name,
                  dept: deptName,
                  date: date,
                  recievedBy: recievedBy,
                  notificationTo: notificationTo,
                  detail: details)
              .toJson())
          .then((value) {
        print('inside then');
        Get.to(
          () => listOfImages(
              fileNum: state.fileNumcontroller.text.trim(),
              FileName: state.nameController.text.trim(),
              date: state.selectedDate,
              recievedBy: state.recievedByController.text.trim(),
              notificationTo: state.notificationToController.text.trim(),
              details: state.detailController.text.trim(),
              deptName: state.deptName.value),
        );

        setLoading(false);
      }).onError((error, stackTrace) {
        print("Error" + error.toString());
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
    }
  }

//   here we manage the section of update the data
  Future<void> showFileNameDialogAlert(
      BuildContext context, String filename, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    state.nameController.text = filename;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('update filename')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: state.nameController,
                      focusNode: state.nameFocusNode,
                      lableText: 'Enter your Filename',
                      onFiledSubmittedValue: (value) {},
                      keyboardType: TextInputType.emailAddress,
                      obsecureText: false,
                      onvalidator: (value) {})
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.warningColor),
                  )),
              TextButton(
                  onPressed: () {
                    //this  code will update the name in database
                    state.ref.doc(id).update({
                      'Name': state.nameController.text.toString()
                    }).then((value) {
                      fetchDataOfFile(id);
                      state.nameController.clear();
                    });

                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme.of(context).textTheme.subtitle2,
                  ))
            ],
          );
        });
  }

  Future<void> showFileNumDialogAlert(
      BuildContext context, String filenum, String id) {
    //this line 104 code mean jo user ka already name ho ga wo show ho
    state.nameController.text = filenum;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('update fileNum')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: state.nameController,
                      focusNode: state.nameFocusNode,
                      lableText: 'Enter your FileNum',
                      onFiledSubmittedValue: (value) {},
                      keyboardType: TextInputType.emailAddress,
                      obsecureText: false,
                      onvalidator: (value) {})
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.warningColor),
                  )),
              TextButton(
                  onPressed: () {
                    //this  code will update the name in database
                    state.ref.doc(id).update({
                      'FileNum': state.fileNumcontroller.text.toString()
                    }).then((value) {
                      fetchDataOfFile(id);
                      state.fileNumcontroller.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ok',
                    style: Theme.of(context).textTheme.subtitle2,
                  ))
            ],
          );
        });
  }

  List<dynamic> fetchedImageUrls = [];
  RxBool fetchedLoading = true.obs;

  setFetchLoading(bool val) {
    fetchedLoading.value = val;
  }

  Future<List<dynamic>> fetchImageUrls(String docId) async {
    setFetchLoading(true);
    final snapshot = await FirebaseFirestore.instance
        .collection('dispatchFile')
        .doc(docId)
        .get();

    final List<String> imageUrls =
        List<String>.from(snapshot.data()!['images']);
    return imageUrls;
  }

//   here we create a function to delete a function
Future<void> deleteFile(String id)async{
    try{
      await state.ref.doc(id).delete().then((value){
        print('File Deleted');
      }).onError((error, stackTrace){
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      Get.snackbar('error', e.toString());
    }

}



}
