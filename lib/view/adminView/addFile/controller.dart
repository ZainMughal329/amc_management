import 'dart:io';

import 'package:amc_management/res/components/SessionViewComponents/custom_tetxField.dart';
import 'package:amc_management/utils/routes/routes_name.dart';
import 'package:amc_management/view/adminView/addFile/components/addFileForm.dart';
import 'package:amc_management/view/adminView/addFile/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/addFile_model/addFile_model.dart';
import '../../../res/colors.dart';
import 'components/listofImages/view.dart';

class addFileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final state = addFileState();
  late TabController tabController;

  addFileController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.dateController.dispose();
    state.filenoController.dispose();
    state.fromController.dispose();
    state.nameController.dispose();
    state.detailFocusNode.dispose();
  }

  AddFileModel? addFileModel;
  DocumentSnapshot? documentSnapshot;

  fetchDataOfFiles(String id) async {
    try{
      documentSnapshot =
      await FirebaseFirestore.instance.collection('addFiles').doc(id).get();
      if (documentSnapshot!.exists) {
        print('id' + id);

        addFileModel = AddFileModel(
            id: id,
            name: documentSnapshot!['Name'],
            dept: documentSnapshot!['dept'],
            // date: documentSnapshot!['Date'],
            from: documentSnapshot!['From'],
            filenum: documentSnapshot!['FileNum'],
            images: images);
        state.nameFile.value = documentSnapshot!['Name'];
        state.fileNum.value = documentSnapshot!['FileNum'];
        state.loaded.value = true;

        print('value of name : ' +state.nameFile.value.toString(),);
        print('value of file number : ' +state.fileNum.value.toString(),);

      } else {
        print('empty');
      }
    } catch(e){
      print('exception : ' + e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    // for image list
    getImageUrls().then((urls) => {state.imageUrls = urls});
  }

  void setLoading(value) {
    state.loading.value = value;
  }

  final picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;
  List<String> images = [];
  String documentId = DateTime.now().millisecondsSinceEpoch.toString();

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

  Future uploadimageonDatabase(String timeStamp) async {
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref('/addFile' + timeStamp);
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final imageUrl = await storageRef.getDownloadURL();
    state.ref.doc(timeStamp).update({
      'image': imageUrl,
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

  Future<void> addFileOnFirebase(
    String detail,
    String timeStamp,
    String name,
    String dept,
    String image,
    String date,
    String fileNum,
    String from,
  ) async {
    setLoading(true);
    try {
      await state.ref.doc(timeStamp).set({
        'Detail': detail,
        'Dept': dept,
        'Name': name,
        'From': from,
        'FileNum': fileNum,
        'Date': date,
        // 'Id':FileId
      }).then((value) {
        setLoading(false);
        Get.snackbar('Success', 'File Added');
        // Get.back();
      }).onError((error, stackTrace) {
        setLoading(false);
        Get.snackbar('Error', error.toString());
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void storeData(
    String detail,
    String timeStamp,
    AddFileModel addFile,
    BuildContext context,
    String name,
    String dept,
    String from,
    String image,
    String fileNum,
    String date,
  ) async {
    setLoading(true);
    addFileOnFirebase(detail, timeStamp, name, dept, image, date, fileNum, from)
        .then((value) {
      uploadimageonDatabase(timeStamp);
      setLoading(false);
      clearDateFromScreen();
    }).onError((error, stackTrace) {
      setLoading(false);
      Get.snackbar('Error', error.toString());
    });
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

  clearDateFromScreen() {
    state.dateController.clear();
    state.fromController.clear();
    state.nameController.clear();
    state.filenoController.clear();
    state.deptName.value = "Select";
    state.detailController.clear();
    images=[];
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getFIleData() {
    return state.ref.doc(state.auth.currentUser!.uid.toString()).snapshots();
  }

//   here we create function to vaLidate THE FORM

  void validateForm() {
    state.isFormValid.value = state.nameController.text.isNotEmpty &&
        state.dateController.text.isNotEmpty &&
        state.filenoController.text.isNotEmpty &&
        state.fromController.text.isNotEmpty &&
        state.detailController.text.isNotEmpty &&
        state.deptName.value.isNotEmpty;
  }

  Future uploadimagelistonDatabase(
      int imageId, String docId, String timeStamp, var imagePath) async {
    final imageUrl;

    try {
      setLoading(true);
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref('/addFile' + timeStamp);
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

  Future<void> addFileDataOnFirebase(
      String id,
      String name,
      final DateTime date,
      String fileNo,
      String deptName,
      String recieverName,
      String details) async {
    try {
      setLoading(true);
      print('inside try');
      await state.ref
          .doc(id)
          .set(AddFileModel(
                  id: id,
                  images: [],
                  name: name,
                  dept: deptName,
                  date: date,
                  from: recieverName,
                  filenum: fileNo,
                  detail: details)
              .toJson())
          .then((value) {
        print('inside then');
        Get.to(() => ListOfFileView(
          details: state.detailController.text
              .trim(),
          date:state.selectedDate,
          fileNo: state.filenoController.text
              .trim(),
          recieverName:
          state.fromController.text.trim(),
          FileName:
          state.nameController.text.trim(),
          deptName: state.deptName.value,
        ));

        setLoading(false);

      }).onError((error, stackTrace) {
        print("Error" + error.toString());

        setLoading(false);

      });
    } catch (e) {
      setLoading(false);

    }
  }

//   here we manage the section of update the file data

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
                    print('id' + id);
                    //this  code will update the name in database
                    state.ref.doc(id).update({
                      'Name': state.nameController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
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
    state.filenoController.text = filenum;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('update username')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ReuseField(
                      myController: state.filenoController,
                      focusNode: state.filenoFocusNode,
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
                      'FileNum': state.filenoController.text.toString()
                    }).then((value) {
                      fetchDataOfFiles(id);
                      state.filenoController.clear();
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

  Future<List<String>> getImageUrls() async {
    final QuerySnapshot querySnapshot = await state.ref.get();

    final List<String> imageUrls = [];
    querySnapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('imageUrl')) {
        final imageUrl = data[
            'images']; // Assuming 'imageUrl' is the field name where you store image URLs.
        imageUrls.add(imageUrl);
      }
    });

    return imageUrls;
  }

  List<dynamic> fetchedImageUrls = [];
  RxBool fetchedLoading = true.obs;

  setFetchLoading(bool val) {
    fetchedLoading.value = val;
  }

  Future<List<dynamic>> fetchImageUrls(String docId) async {
    setFetchLoading(true);
    final snapshot = await FirebaseFirestore.instance
        .collection('addFiles')
        .doc(docId)
        .get();

    final List<String> imageUrls =
        List<String>.from(snapshot.data()!['images']);
    return imageUrls;
  }

//   here we create a function to delelete files

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
