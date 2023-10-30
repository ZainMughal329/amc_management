import 'dart:io';

import 'package:amc_management/view/adminView/addFile/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/addFile_model/addFile_model.dart';
import '../../../res/colors.dart';

class addFileController extends GetxController with GetSingleTickerProviderStateMixin{
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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
  void setLoading(bool value){
    state.loading.value = value;
  }
  final picker =ImagePicker();
  XFile? _image;
  XFile? get image=>_image;



  Future pickCameraImage(BuildContext context)async{
    final image = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);
    if(image!=null){
      _image = XFile(image.path);
      update();
    }
  }
  Future pickGalleryImage(BuildContext context)async{

    final image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
    if(image!=null){
      _image = XFile(image.path);
      update();
    }
  }

  Future uploadimageonDatabase (String timeStamp) async{
    firebase_storage.Reference storageRef =firebase_storage.FirebaseStorage.instance.ref('/addFile'+timeStamp);
    firebase_storage.UploadTask uploadTask =storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final imageUrl = await storageRef.getDownloadURL();
    state.ref.doc(timeStamp).update({
      'image': imageUrl,
    }).then((value){
      print('File uploaded and stored');
    });

  }

  void pickImage(context){
    Get.dialog(AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                pickCameraImage(context);
                Get.back();
              },
              title: Text('Camera'),
              leading: Icon(Icons.camera,color: AppColors.lightActiveIconColor,),
            ),
            ListTile(
              onTap: (){
                pickGalleryImage(context);
                Get.back();
              },
              title: Text('Gallery'),
              leading: Icon(Icons.image,color: AppColors.lightActiveIconColor,),
            ),
          ],
        ),
      ),
    ));
  }
  Future<void> addFileOnFirebase(String detail,String timeStamp, String name,String dept,String image,String date,String fileNum,String from,)async{
     setLoading(true);
    try{
      await state.ref.doc(timeStamp).set({
        'Detail':detail,
        'Dept':dept,
        'Name':name,
        'From':from,
        'FileNum':fileNum,
        'Date':date,
        // 'Id':FileId
      }).then((value) {
        setLoading(false);
        Get.snackbar('Success', 'File Added');
        // Get.back();
      }).onError((error, stackTrace) {
        setLoading(false);
        Get.snackbar('Error', error.toString());
      });
    }catch(e){
      Get.snackbar('Error',e.toString());
    }
  }
  void storeData(
      String detail,
      String timeStamp,
  AddFileModel addFile,
      BuildContext context,String name ,
      String dept,
      String from,String image,String fileNum,String date,
      )async{
    setLoading(true);
    addFileOnFirebase(detail,timeStamp,name,dept, image, date, fileNum, from).then((value){
      uploadimageonDatabase(timeStamp);
      setLoading(false);
      clearDateFromScreen();
    }).onError((error, stackTrace){
      setLoading(false);
      Get.snackbar('Error', error.toString());    });
  }
  getDateFromUser(BuildContext context)async{
    DateTime? pickerDate= await  showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1978),
        lastDate: DateTime(2099));
    if(pickerDate!=null){
      state.selectedDate=pickerDate;
      update();
    }else{
      print('select a date ');
    }
  }
  clearDateFromScreen(){
    state.dateController.clear();
    state.fromController.clear();
    state.nameController.clear();
    state.filenoController.clear();
    state.deptName.value="Select";
    state.detailController.clear();
  }
  Stream<DocumentSnapshot<Map<String,dynamic>>> getFIleData(){
    return state.ref.doc(state.auth.currentUser!.uid.toString()).snapshots();
  }
}





